// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rh_host/src/core/constants/constants.dart';
import 'package:rh_host/src/core/enum/%20error_catogory.dart';
import 'package:rh_host/src/core/errror/error_codes.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/core/extension/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    required this.prefs,
    required this.firestoreClient,
  });

  final SharedPreferences prefs;
  final FirebaseFirestore firestoreClient;

  final String _passcodeKey = 'user_passcode';
  final String _passcodeEnabledKey = 'passcode_enabled';
  final String _lastLoginTimestampKey = 'last_login_timestamp';

  @override
  Future<bool> enableDisablePasscode() async {
    try {
      // Get the current state of the passcode
      final isPasscodeEnabled = prefs.getBool(_passcodeEnabledKey) ?? false;

      // Toggle the state
      final newState = !isPasscodeEnabled;

      // Update SharedPreferences
      await prefs.setBool(_passcodeEnabledKey, newState);

      if (newState) {
        // If enabling passcode, set the last login timestamp to now
        await prefs.setString(_lastLoginTimestampKey, DateTime.now().toIso8601String());
      } else {
        // If disabling passcode, clear related data
        await prefs.remove(_lastLoginTimestampKey);
      }

      return newState;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw CacheException(
        message: 'Error toggling passcode screen: $e',
        code: '500',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> shouldShowPasscode() async {
    try {
      // Check if passcode is enabled in SharedPreferences
      // _passcodeEnabledKey == true -- showPasscode show
      // _passcodeEnabledKey == false -- no showPasscode show
      // we only need to check whether this is false or not
      final isPasscodeShown = prefs.getBool(_passcodeEnabledKey) ?? false;

      if (!isPasscodeShown) {
        return false;
      }

      // Check if there's a lastLoginTimestamp in SharedPreferences
      final lastLoginString = prefs.getString(_lastLoginTimestampKey);
      if (lastLoginString == null) {
        return true; // If there's no last login time, we should show the passcode
      }

      // Parse the stored timestamp
      final lastLogin = DateTime.parse(lastLoginString);

      // Check if it's been more than 30 minutes since the last login
      final timeSinceLastLogin = DateTime.now().difference(lastLogin);
      return timeSinceLastLogin.inMinutes > 30;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: 'Failed to check if passcode should be shown',
        details: e.toString(),
        stackTrace: s,
        code: e.toString(),
      );
    }
  }

  @override
  Future<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    try {
      // Verify that new passcode and confirmation match
      if (newPasscode != confirmPasscode) {
        throw const ServerException(
          message: Constants.noMatchPasscode,
          code: ErrorCode.noMatchingPasscode,
          errorCategory: ErrorCategory.validation,
        );
      }

      // Verify master passcode
      final docSnapshot = await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .get();

      final storedMasterPasscode = docSnapshot.data()?[Constants.masterPasscode] as int?;

      if (storedMasterPasscode == null || storedMasterPasscode != masterPasscode) {
        throw const ServerException(
          message: Constants.invalidMasterPasscode,
          code: ErrorCode.noMatchingMasterPasscode,
          errorCategory: ErrorCategory.validation,
        );
      }

      // Set new passcode in Firestore
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set(
        {
          Constants.appPasscode: newPasscode,
          Constants.lastLoginupdatedAt: FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      // Set new passcode in SharedPreferences
      await prefs.setInt(_passcodeKey, newPasscode);

      // Enable passcode if it wasn't already enabled
      if (!prefs.getBool(_passcodeEnabledKey)!) {
        await prefs.setBool(_passcodeEnabledKey, true);
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        code: ErrorCode.firebaseError,
        errorCategory: ErrorCategory.firebase,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: '${Constants.failedToSetNewPasscode}: $e',
        code: ErrorCode.unknown,
      );
    }
  }

  @override
  Future<bool> verifyPasscode(int passcode) async {
    try {
      // Fetch the passcode document from Firestore
      final docSnapshot = await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .get();

      // Check if the document exists and contains a passcode
      if (!docSnapshot.exists ||
          !docSnapshot.data()!.containsKey(Constants.appPasscode)) {
        throw const ServerException(
          message: Constants.passcodeNotSet,
          code: ErrorCode.notFoundPasscode,
          errorCategory: ErrorCategory.notFoundPasscode,
        );
      }

      final firestorePasscode = docSnapshot.data()![Constants.appPasscode] as int;

      // Compare the entered passcode with the one stored in Firestore
      if (passcode != firestorePasscode) {
        return false;
      }

      // Passcode is correct
      // Update last verification time in local storage
      final now = DateTime.now().toIso8601String();
      await prefs.setString(_lastLoginTimestampKey, now);

      return true;
    } on FirebaseException catch (e, s) {
      // e.code; - error codes
      // e.message; - user friendly message
      // e.stackTrace; - error description
      // e.plugin; - which firebase services

      throw ServerException(
        message: e.message ?? 'Firebase Error Occurred',
        code: e.code,
        errorCategory: e.plugin.getErrorCategory,
        stackTrace: s,
        details: e.stackTrace.toString(),
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: Constants.failedToVerifyPasscode,
        stackTrace: s,
        code: ErrorCode.unknown,
      );
    }
  }
}
