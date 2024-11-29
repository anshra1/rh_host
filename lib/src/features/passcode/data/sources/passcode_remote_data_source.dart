// ignore_for_file: lines_longer_than_80_chars, require_trailing_commas

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rh_host/src/core/clock/clock_provider.dart';
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/error/errror_system/retry_policy.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/error/exception/exception_thrower.dart';
import 'package:rh_host/src/core/network/network_info.dart';
import 'package:rh_host/src/core/network/operation_helper.dart';
import 'package:rh_host/src/core/storage/shared_pref_storage.dart';
import 'package:rh_host/src/core/storage/storage_keys.dart';

abstract class PasscodeRemoteDataSource {
  Future<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  });

  Future<bool> verifyPasscode(int passcode);

  Future<void> enableDisablePasscode();

  Future<bool> shouldShowPasscode();
}

class PasscodeRemoteDataSourceImpl implements PasscodeRemoteDataSource {
  PasscodeRemoteDataSourceImpl({
    required SharedPrefsStorage prefs,
    required FirebaseFirestore firestoreClient,
    required TimeProvider timeProvider,
    required NetworkCheckerImpl networkChecker,
    required RetryPolicy retryPolicy,
  })  : _prefs = prefs,
        _timeProvider = timeProvider,
        _networkInfo = networkChecker,
        _retryPolicy = retryPolicy,
        _firestoreClient = firestoreClient;

  final SharedPrefsStorage _prefs;
  final FirebaseFirestore _firestoreClient;
  final TimeProvider _timeProvider;
  final NetworkCheckerImpl _networkInfo;
  final RetryPolicy _retryPolicy;

  @override
  Future<void> enableDisablePasscode() async {
    const methodName = 'ENABLE_DISABLE_PASSCODE';
    try {
      final isPasscodeEnabled =
          await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;

      // Toggle the state
      final newState = !isPasscodeEnabled;

      if (newState) {
        // If enabling passcode
        await Future.wait([
          _prefs.write<bool>(StorageKeys.passcodeEnabledKey, true),
          _prefs.write<String>(
            StorageKeys.lastLoginTimestampKey,
            _timeProvider.currentTime.toIso8601String(),
          ),
        ]);
      } else {
        // If disabling passcode
        await Future.wait([
          _prefs.write<bool>(StorageKeys.passcodeEnabledKey, false),
          _prefs.delete(StorageKeys.lastLoginTimestampKey),
        ]);
      }
    } catch (e, s) {
      // Handle any other unexpected errors
      throw ExceptionThrower.unknownException(
        error: e,
        stackTrace: s,
        methodName: methodName,
      );
    }
  }

  @override
  Future<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    const methodName = 'SET_NEW_PASSCODE';

    try {
      // Local validation doesn't need remote operation wrapper
      await _validatePasscodes(newPasscode, confirmPasscode);

      // Wrap only the Firebase operations that need network/retry
      await RemoteDataSourceHelper.executeRetryOperation(
        methodName: methodName,
        networkInfo: _networkInfo,
        retryPolicy: _retryPolicy,
        operation: () async {
          await _verifyAndSetPasscode(masterPasscode, newPasscode);
        },
      );

      // Local SharedPrefs operations don't need remote wrapper
      await _updatePasscodeState();
    } catch (e, s) {
      throw ExceptionThrower.throwUnknownExceptionWithFirebase(
        error: e,
        stackTrace: s,
        methodName: methodName,
      );
    }
  }

  Future<void> _validatePasscodes(int newPasscode, int confirmPasscode) async {
    if (newPasscode != confirmPasscode) {
      throw const ValidationException(
        showUImessage: Strings.noMatchPasscode,
        debugCode: 'ErrorCode.validation',
        methodName: 'SET_NEW_PASSCODE',
        errorCode: ErrorCode.validation,
      );
    }
  }

  // This operation needs network/retry as it interacts with Firebase
  Future<void> _verifyAndSetPasscode(int masterPasscode, int newPasscode) async {
    final docSnapshot = await _firestoreClient
        .collection(Strings.passcodeStoreCollection)
        .doc(Strings.passcodeStoreDocId)
        .get();

    final storedMasterPasscode = docSnapshot.data()?[Strings.setMasterPasscode] as int?;

    if (storedMasterPasscode == null || storedMasterPasscode != masterPasscode) {
      throw const ValidationException(
        showUImessage: Strings.invalidMasterPasscode,
        debugCode: 'ErrorCode.validation',
        methodName: 'SET_NEW_PASSCODE',
        errorCode: ErrorCode.validation,
        debugDetails: 'Invalid master passcode provided.',
      );
    }

    await _firestoreClient
        .collection(Strings.passcodeStoreCollection)
        .doc(Strings.passcodeStoreDocId)
        .set(
      {
        Strings.appPasscode: newPasscode,
        Strings.passcodeLastLoginupdatedAt: FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // Local operation doesn't need remote wrapper
  Future<void> _updatePasscodeState() async {
    final isEnabled = await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;
    if (!isEnabled) {
      await _prefs.write<bool>(StorageKeys.passcodeEnabledKey, true);
    }
  }

  @override
  Future<bool> shouldShowPasscode() async {
    const methodName = 'SHOULD_SHOW_PASSCODE';
    try {
      // Check if passcode is enabled in SharedPreferences
      // _passcodeEnabledKey == true -- showPasscode show
      // _passcodeEnabledKey == false -- no showPasscode show
      // we only need to check whether this is false or not
      final isPasscodeShown =
          await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;

      if (!isPasscodeShown) {
        return false;
      }

      // Check if there's a lastLoginTimestamp in SharedPreferences
      final lastLoginString =
          await _prefs.read<String>(StorageKeys.lastLoginTimestampKey);

      if (lastLoginString == null) {
        return true; // If there's no last login time, we should show the passcode
      }

      // Parse the stored timestamp
      final lastLogin = DateTime.parse(lastLoginString);

      // Check if it's been more than 30 minutes since the last login
      final timeSinceLastLogin = _timeProvider.currentTime.difference(lastLogin);
      return timeSinceLastLogin.inMinutes > 30;
    } catch (e, s) {
      throw ExceptionThrower.throwUnknownExceptionWithFirebase(
        error: e,
        stackTrace: s,
        methodName: methodName,
      );
    }
  }

  @override
  Future<bool> verifyPasscode(int passcode) async {
    const methodName = 'VERIFY_PASSCODE';

    try {
      // Local validations - no retry needed
      await _performLocalValidations(passcode);

      // Remote operation with retry
      final isValid = await _verifyPasscodeWithFirestore(passcode);

      if (isValid) {
        // Only update lastLoginTimestampKey on successful verification
        await _prefs.write<String>(
          StorageKeys.lastLoginTimestampKey,
          _timeProvider.currentTime.toIso8601String(),
        );
      }

      return isValid;
    } catch (e, s) {
      throw ExceptionThrower.throwUnknownExceptionWithFirebase(
        error: e,
        stackTrace: s,
        methodName: methodName,
      );
    }
  }

  Future<void> _performLocalValidations(int passcode) async {
    const methodName = 'VERIFY_PASSCODE_performLocalValidations';

    // 2. Check input validation
    if (passcode.toString().length != 6) {
      throw const ValidationException(
        debugCode: 'invalid_passcode_format',
        methodName: methodName,
        errorCode: ErrorCode.validation,
        showUImessage: 'Invalid passcode format',
      );
    }
  }

  Future<bool> _verifyPasscodeWithFirestore(int passcode) async {
    return RemoteDataSourceHelper.executeRetryOperation(
      operation: () async {
        final docSnapshot = await _firestoreClient
            .collection(Strings.passcodeStoreCollection)
            .doc(Strings.passcodeStoreDocId)
            .get();

        if (!docSnapshot.exists ||
            !docSnapshot.data()!.containsKey(Strings.appPasscode)) {
          throw const ValidationException(
            debugCode: 'passcode_not_configured',
            methodName: 'VERIFY_PASSCODE_verifyPasscodeWithFirestore',
            errorCode: ErrorCode.notFoundPasscode,
            showUImessage: Strings.passcodeNotSet,
          );
        }

        final storedPasscode = docSnapshot.data()![Strings.appPasscode];
        if (storedPasscode is! int) {
          throw const ValidationException(
            debugCode: 'invalid_stored_passcode_type',
            methodName: 'VERIFY_PASSCODE_verifyPasscodeWithFirestore',
            errorCode: ErrorCode.validation,
            showUImessage: 'System error: Invalid passcode configuration',
          );
        }

        return passcode == storedPasscode;
      },
      methodName: 'VERIFY_PASSCODE_verifyPasscodeWithFirestore',
      networkInfo: _networkInfo,
      retryPolicy: _retryPolicy,
    );
  }
}
