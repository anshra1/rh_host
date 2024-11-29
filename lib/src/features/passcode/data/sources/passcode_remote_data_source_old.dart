// // ignore_for_file: lines_longer_than_80_chars

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rh_host/src/core/clock/clock_provider.dart';
// import 'package:rh_host/src/core/constants/string.dart';
// import 'package:rh_host/src/core/enum/error_codes.dart';
// import 'package:rh_host/src/core/error/exception/exception.dart';
// import 'package:rh_host/src/core/error/exception/exception_thrower.dart';
// import 'package:rh_host/src/core/storage/shared_pref_storage.dart';
// import 'package:rh_host/src/core/storage/storage_keys.dart';

// abstract class PasscodeRemoteDataSource {
//   Future<void> setNewPasscode({
//     required int newPasscode,
//     required int confirmPasscode,
//     required int masterPasscode,
//   });

//   Future<bool> verifyPasscode(int passcode);

//   Future<void> enableDisablePasscode();

//   Future<bool> shouldShowPasscode();
// }

// class PasscodeRemoteDataSourceImpl implements PasscodeRemoteDataSource {
//   PasscodeRemoteDataSourceImpl({
//     required SharedPrefsStorage prefs,
//     required FirebaseFirestore firestoreClient,
//     required TimeProvider timeProvider,
//   })  : _prefs = prefs,
//         _timeProvider = timeProvider,
//         _firestoreClient = firestoreClient;

//   final SharedPrefsStorage _prefs;
//   final FirebaseFirestore _firestoreClient;
//   final TimeProvider _timeProvider;

//   @override
//   Future<void> enableDisablePasscode() async {
//     const methodName = 'ENABLE_DISABLE_PASSCODE';
//     try {
//       final isPasscodeEnabled =
//           await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;

//       // Toggle the state
//       final newState = !isPasscodeEnabled;

//       if (newState) {
//         // If enabling passcode
//         await Future.wait([
//           _prefs.write<bool>(StorageKeys.passcodeEnabledKey, true),
//           _prefs.write<String>(
//             StorageKeys.lastLoginTimestampKey,
//             _timeProvider.currentTime.toIso8601String(),
//           ),
//         ]);
//       } else {
//         // If disabling passcode
//         await Future.wait([
//           _prefs.write<bool>(StorageKeys.passcodeEnabledKey, false),
//           _prefs.delete(StorageKeys.lastLoginTimestampKey),
//         ]);
//       }
//     } catch (e, s) {
//       // Handle any other unexpected errors
//       throw ExceptionThrower.unknownException(
//         error: e,
//         stackTrace: s,
//         methodName: methodName,
//       );
//     }
//   }

//   @override
//   Future<bool> shouldShowPasscode() async {
//     const methodName = 'SHOULD_SHOW_PASSCODE';
//     try {
//       // Check if passcode is enabled in SharedPreferences
//       // _passcodeEnabledKey == true -- showPasscode show
//       // _passcodeEnabledKey == false -- no showPasscode show
//       // we only need to check whether this is false or not
//       final isPasscodeShown =
//           await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;

//       if (!isPasscodeShown) {
//         return false;
//       }

//       // Check if there's a lastLoginTimestamp in SharedPreferences
//       final lastLoginString =
//           await _prefs.read<String>(StorageKeys.lastLoginTimestampKey);

//       if (lastLoginString == null) {
//         return true; // If there's no last login time, we should show the passcode
//       }

//       // Parse the stored timestamp
//       final lastLogin = DateTime.parse(lastLoginString);

//       // Check if it's been more than 30 minutes since the last login
//       final timeSinceLastLogin = _timeProvider.currentTime.difference(lastLogin);
//       return timeSinceLastLogin.inMinutes > 30;
//     } catch (e, s) {
//       throw ExceptionThrower.throwUnknownExceptionWithFirebase(
//         error: e,
//         stackTrace: s,
//         methodName: methodName,
//       );
//     }
//   }

//   @override
//   Future<void> setNewPasscode({
//     required int newPasscode,
//     required int confirmPasscode,
//     required int masterPasscode,
//   }) async {
//     const methodName = 'SET_NEW_PASSCODE';
//     try {
//       // Verify that new passcode and confirmation match
//       if (newPasscode != confirmPasscode) {
//         throw const ValidationException(
//           showUImessage: Strings.noMatchPasscode,
//           debugCode: 'ErrorCode.validation',
//           methodName: 'SET_NEW_PASSCODE',
//           errorCode: ErrorCode.validation,
//         );
//       }

//       // Verify master passcode
//       final docSnapshot = await _firestoreClient
//           .collection(Strings.passcodeStoreCollection)
//           .doc(Strings.passcodeStoreDocId)
//           .get();

//       final storedMasterPasscode = docSnapshot.data()?[Strings.setMasterPasscode] as int?;

//       if (storedMasterPasscode == null || storedMasterPasscode != masterPasscode) {
//         throw const ValidationException(
//           showUImessage: Strings.invalidMasterPasscode,
//           debugCode: 'ErrorCode.validation',
//           methodName: 'SET_NEW_PASSCODE',
//           errorCode: ErrorCode.validation,
//           debugDetails: 'Invalid master passcode provided.',
//         );
//       }

//       // Set new passcode in Firestore
//       await _firestoreClient
//           .collection(Strings.passcodeStoreCollection)
//           .doc(Strings.passcodeStoreDocId)
//           .set(
//         {
//           Strings.appPasscode: newPasscode,
//           Strings.passcodeLastLoginupdatedAt: FieldValue.serverTimestamp(),
//         },
//         SetOptions(merge: true),
//       );

//       // Set new passcode in SharedPreferences
//       // No use for now
//       //  await _prefs.write<int>(StorageKeys.passcodeKey, newPasscode);

//       // Enable passcode if it wasn't already enabled
//       final key = await _prefs.read<bool>(StorageKeys.passcodeEnabledKey) ?? false;
//       if (!key) {
//         await _prefs.write<bool>(StorageKeys.passcodeEnabledKey, true);
//       }
//     } catch (e, s) {
//       throw ExceptionThrower.throwUnknownExceptionWithFirebase(
//         error: e,
//         stackTrace: s,
//         methodName: methodName,
//       );
//     }
//   }

//   @override
//   Future<bool> verifyPasscode(int passcode) async {
//     const methodName = 'VERIFY_PASSCODE';
//     try {
//       // Fetch the passcode document from Firestore
//       final docSnapshot = await _firestoreClient
//           .collection(Strings.passcodeStoreCollection)
//           .doc(Strings.passcodeStoreDocId)
//           .get();

//       // Check if the document exists and contains a passcode
//       if (!docSnapshot.exists || !docSnapshot.data()!.containsKey(Strings.appPasscode)) {
//         throw ExceptionThrower.validationException(
//           debugCode: 'not found key',
//           methodName: methodName,
//           messsage: 'Firebase does have passcode key Problem \n'
//               ' if (!docSnapshot.exists || !docSnapshot.data()!.containsKey(Strings.appPasscode))',
//         );
//       }

//       final firestorePasscode = docSnapshot.data()![Strings.appPasscode] as int;

//       // Compare the entered passcode with the one stored in Firestore
//       if (passcode != firestorePasscode) {
//         return false;
//       }

//       // Passcode is correct
//       // Update last verification time in local storage
//       final now = _timeProvider.currentTime.toIso8601String();
//       await _prefs.write<String>(StorageKeys.lastLoginTimestampKey, now);

//       return true;
//     } catch (e, s) {
//       throw ExceptionThrower.throwUnknownExceptionWithFirebase(
//         error: e,
//         stackTrace: s,
//         methodName: methodName,
//       );
//     }
//   }
// }
