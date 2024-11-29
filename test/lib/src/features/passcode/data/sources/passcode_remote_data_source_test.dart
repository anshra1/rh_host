// ignore_for_file: lines_longer_than_80_chars, no_leading_underscores_for_local_identifiers

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/constants/constants.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

const String passcodeKey = 'user_passcode';
const String passcodeEnabledKey = 'passcode_enabled';

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late MockSharedPreferences prefs;
  late PasscodeRemoteDataSourceImpl passcodeRepoImpl;

  setUp(() {
    firestoreClient = FakeFirebaseFirestore();
    prefs = MockSharedPreferences();
    passcodeRepoImpl = PasscodeRemoteDataSourceImpl(
      firestoreClient: firestoreClient,
      prefs: prefs,
    );
  });

  group('setNewPasscode', () {
    const newPasscode = 1234;
    const confirmPasscode = 1234;
    const masterPasscode = 5678;

    test('should set new passcode successfully', () async {
      // Arrange
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set({
        Constants.masterPasscode: masterPasscode,
      });

      when(() => prefs.setInt(any(), any())).thenAnswer((_) async => true);
      when(() => prefs.getBool(any())).thenReturn(false);
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      // Act
      await passcodeRepoImpl.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      final docSnapshot = await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .get();

      expect(docSnapshot.data()?[Constants.appPasscode], newPasscode);

      verify(() => prefs.setInt(passcodeKey, newPasscode)).called(1);
      verify(() => prefs.setBool(passcodeEnabledKey, true)).called(1);
    });

    test('should throw ServerException when new passcode and confirmation do not match',
        () async {
      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: 4321, // Different from newPasscode
          masterPasscode: masterPasscode,
        ),
        throwsA(
          isA<ServerException>()
              .having((e) => e.message, 'message', Constants.noMatchPasscode),
        ),
      );
    });

    test('should throw ServerException when master passcode is invalid', () async {
      // Arrange
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set({
        Constants.masterPasscode: 9999, // Different from provided masterPasscode
      });

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(
          isA<ServerException>()
              .having((e) => e.message, 'message', Constants.invalidMasterPasscode),
        ),
      );
    });

    test('should rethrow ServerException', () async {
      // Arrange
      when(() => prefs.setInt(any(), any())).thenThrow(
        const ServerException(message: 'Prefs error', statusCode: 500),
      );

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when an unexpected error occurs', () async {
      // Arrange
      when(() => prefs.setInt(any(), any())).thenThrow(Exception('Unexpected error'));

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('verifyPasscode', () {
    const correctPasscode = 1234;
    const incorrectPasscode = 5678;

    test('should return true when passcode is correct', () async {
      // Arrange
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set({
        Constants.appPasscode: correctPasscode,
      });

      // Act
      final result = await passcodeRepoImpl.verifyPasscode(correctPasscode);

      // Assert
      expect(result, true);

      // Verify that lastLoginupdatedAt was updated
      final updatedDoc = await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .get();

      expect(updatedDoc.data()!.containsKey(Constants.lastLoginupdatedAt), true);
    });

    test('should return false when passcode is incorrect', () async {
      // Arrange
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set({
        Constants.appPasscode: correctPasscode,
      });

      // Act
      final result = await passcodeRepoImpl.verifyPasscode(incorrectPasscode);

      // Assert
      expect(result, false);
    });

    test('should throw ServerException when passcode document does not exist', () async {
      // Act & Assert
      expect(
        () => passcodeRepoImpl.verifyPasscode(correctPasscode),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when appPasscode field is missing', () async {
      // Arrange
      await firestoreClient
          .collection(Constants.settingCollectionName)
          .doc(Constants.passcodeDocId)
          .set({
        'someOtherField': 'someValue',
      });

      // Act & Assert
      expect(
        () => passcodeRepoImpl.verifyPasscode(correctPasscode),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('shouldShowPasscode', () {
    const _passcodeEnabledKey = 'passcode_enabled';
    const _lastLoginTimestampKey = 'last_login_timestamp';

    test('should return false when passcode is not enabled', () async {
      // Arrange
      when(() => prefs.getBool(_passcodeEnabledKey)).thenReturn(false);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
      verify(() => prefs.getBool(_passcodeEnabledKey)).called(1);

      verifyNoMoreInteractions(prefs);
    });

    test('should return false when passcode enabled key is null', () async {
      // Arrange
      when(() => prefs.getBool(_passcodeEnabledKey)).thenReturn(null);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
      verify(() => prefs.getBool(_passcodeEnabledKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true when passcode is enabled but no last login timestamp',
        () async {
      // Arrange
      when(() => prefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => prefs.getString(_lastLoginTimestampKey)).thenReturn(null);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, true);
      verify(() => prefs.getBool(_passcodeEnabledKey)).called(1);
      verify(() => prefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should return true when last login was more than 30 minutes ago', () async {
      // Arrange
      final oldTimestamp =
          DateTime.now().subtract(const Duration(minutes: 31)).toIso8601String();
      when(() => prefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => prefs.getString(_lastLoginTimestampKey)).thenReturn(oldTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, true);
      verify(() => prefs.getBool(passcodeEnabledKey)).called(1);
      verify(() => prefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should return false when last login was less than 30 minutes ago', () async {
      // Arrange
      final recentTimestamp =
          DateTime.now().subtract(const Duration(minutes: 29)).toIso8601String();

      when(() => prefs.getBool(passcodeEnabledKey)).thenReturn(true);
      when(() => prefs.getString(_lastLoginTimestampKey)).thenReturn(recentTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
      verify(() => prefs.getBool(passcodeEnabledKey)).called(1);
      verify(() => prefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should throw ServerException when SharedPreferences throws an error', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey))
          .thenThrow(const ServerException(message: '', statusCode: 444));

      // Act & Assert
      expect(
        () => passcodeRepoImpl.shouldShowPasscode(),
        throwsA(isA<ServerException>()),
      );
    });

    test('should throw ServerException when timestamp parsing fails', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey)).thenReturn(true);
      when(() => prefs.getString(_lastLoginTimestampKey)).thenReturn('invalid_timestamp');

      // Act & Assert
      expect(
        () => passcodeRepoImpl.shouldShowPasscode(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('enableDisablePasscode', () {
    const passcodeEnabledKey = 'passcode_enabled';
    const lastLoginTimestampKey = 'last_login_timestamp';

    test('should enable passcode when it was disabled', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey)).thenReturn(false);

      when(() => prefs.setBool(passcodeEnabledKey, any())).thenAnswer((_) async => true);

      when(() => prefs.setString(lastLoginTimestampKey, any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await passcodeRepoImpl.enableDisablePasscode();

      // Assert
      expect(result, true);
      verify(() => prefs.setBool(passcodeEnabledKey, true)).called(1);
      verify(() => prefs.setString(lastLoginTimestampKey, any())).called(1);
    });

    test('should disable passcode when it was enabled', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey)).thenReturn(true);

      when(() => prefs.setBool(passcodeEnabledKey, any())).thenAnswer((_) async => true);

      when(() => prefs.remove(any())).thenAnswer((_) async => true);

      // Act
      final result = await passcodeRepoImpl.enableDisablePasscode();

      // Assert
      expect(result, false);

      verify(() => prefs.setBool(passcodeEnabledKey, false)).called(1);
      verify(() => prefs.remove(lastLoginTimestampKey)).called(1);
    });

    test('should enable passcode when current state is null', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey)).thenReturn(null);
      when(() => prefs.setBool(passcodeEnabledKey, any())).thenAnswer((_) async => true);
      when(() => prefs.setString(lastLoginTimestampKey, any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await passcodeRepoImpl.enableDisablePasscode();

      // Assert
      expect(result, true);
      verify(() => prefs.setBool(passcodeEnabledKey, true)).called(1);
      verify(() => prefs.setString(lastLoginTimestampKey, any())).called(1);
    });

    test('should throw ServerException when SharedPreferences throws', () async {
      // Arrange
      when(() => prefs.getBool(passcodeEnabledKey))
          .thenThrow(const CacheException(message: '', statusCode: 666));

      // Act & Assert
      expect(
        () => passcodeRepoImpl.enableDisablePasscode(),
        throwsA(isA<CacheException>()),
      );
    });
  });
}
