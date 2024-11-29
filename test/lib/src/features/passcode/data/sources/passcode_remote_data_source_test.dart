// ignore_for_file: lines_longer_than_80_chars, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:clock/clock.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/clock/clock_provider.dart';
import 'package:rh_host/src/core/clock/time_config.dart';
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/errror_system/retry_policy.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/network/network_info.dart';
import 'package:rh_host/src/core/storage/shared_pref_storage.dart';
import 'package:rh_host/src/core/storage/storage_keys.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockNetworkCheckerImpl extends Mock implements NetworkCheckerImpl {}

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late MockSharedPreferences mockPrefs;
  late SharedPrefsStorage sharedPrefsStorage;
  late PasscodeRemoteDataSourceImpl passcodeRepoImpl;
  late TimeProvider timeProvider;
  late MockNetworkCheckerImpl mockNetworkChecker;

  setUp(() async {
    mockNetworkChecker = MockNetworkCheckerImpl();

    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.reload()).thenAnswer((_) async {});
    sharedPrefsStorage = SharedPrefsStorage(prefs: mockPrefs);
    firestoreClient = FakeFirebaseFirestore();
    timeProvider = const TimeProvider(config: TimeConfig());

    passcodeRepoImpl = PasscodeRemoteDataSourceImpl(
      firestoreClient: firestoreClient,
      prefs: sharedPrefsStorage,
      timeProvider: timeProvider,
      networkChecker: mockNetworkChecker,
      retryPolicy: const RetryPolicy(),
    );

    // // Basic mock setup
    // when(() => mockPrefs.reload()).thenAnswer((_) async => {});
    // when(() => mockPrefs.getBool(any())).thenReturn(false);
    // when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);

    when(() => mockNetworkChecker.isConnected).thenAnswer((_) async => true);
  });

  tearDown(() {
    reset(mockPrefs);
  });
  group('setNewPasscode', () {
    const newPasscode = 1234;
    const confirmPasscode = 1234;
    const masterPasscode = 5678;

    test('should set new passcode successfully', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.setMasterPasscode: masterPasscode,
      });

      when(() => mockPrefs.setInt(any(), any())).thenAnswer((_) async => true);
      when(() => mockPrefs.getBool(any())).thenReturn(false);
      when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);

      // Act
      await passcodeRepoImpl.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      final docSnapshot = await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .get();

      expect(docSnapshot.data()?[Strings.appPasscode], newPasscode);

      verify(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).called(1);
      verify(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true)).called(1);
    });

    test(
        'should throw ValidationException with correct properties when passcodes mismatch',
        () async {
      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: 4321,
          masterPasscode: masterPasscode,
        ),
        throwsA(
          allOf([
            isA<ValidationException>(),
            predicate<ValidationException>(
              (e) => e.showUImessage == Strings.noMatchPasscode,
            ),
            predicate<ValidationException>((e) => e.methodName == 'SET_NEW_PASSCODE'),
            predicate<ValidationException>((e) => e.errorCode == ErrorCode.validation),
            predicate<ValidationException>((e) => e.severity == ErrorSeverity.low),
          ]),
        ),
      );
    });

    test('should throw ValidationException when master passcode is invalid', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.setMasterPasscode: 9999, // Different from provided masterPasscode
      });

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(
          allOf([
            isA<ValidationException>(),
            predicate<ValidationException>(
              (e) => e.showUImessage == Strings.invalidMasterPasscode,
            ),
            predicate<ValidationException>((e) => e.methodName == 'SET_NEW_PASSCODE'),
            predicate<ValidationException>((e) => e.errorCode == ErrorCode.validation),
            predicate<ValidationException>((e) => e.severity == ErrorSeverity.low),
          ]),
        ),
      );
    });

    test('should rethrow ValidationException', () async {
      //  Arrange
      when(() => mockPrefs.setInt(any(), any())).thenThrow(
        const ValidationException(
          showUImessage: Strings.invalidMasterPasscode,
          debugCode: 'ErrorCode.validation',
          methodName: 'SET_NEW_PASSCODE',
          errorCode: ErrorCode.validation,
        ),
      );

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('should throw StorageException when read set an bool in sharedPrefStorage',
        () async {
      // Arrange
      when(() => mockPrefs.setBool(any(), any())).thenThrow(
        const UnknownException(
          debugCode: 'error',
          showUImessage: Strings.unknownError,
          errorCode: ErrorCode.unknown,
          methodName: 'SET_NEW_PASSCODE',
        ),
      );

      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.setMasterPasscode: masterPasscode,
      });

      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
        throwsA(isA<StorageException>()),
      );
    });
  });

  group('shouldShowPasscode', () {
    const _passcodeEnabledKey = StorageKeys.passcodeEnabledKey;
    const _lastLoginTimestampKey = StorageKeys.lastLoginTimestampKey;

    test('should return false when passcode is not enabled', () async {
      // Arrange
      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);

      verify(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).called(1);

      //  verifyNoMoreInteractions(mockPrefs);
    });

    test('should return false when passcode enabled key is null', () async {
      // Arrange
      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenReturn(null);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
      verify(() => mockPrefs.getBool(_passcodeEnabledKey)).called(1);
    });

    test('should return true when passcode is enabled but no last login timestamp',
        () async {
      // Arrange
      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(_lastLoginTimestampKey)).thenReturn(null);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, true);
      verify(() => mockPrefs.getBool(_passcodeEnabledKey)).called(1);
      verify(() => mockPrefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should return true when last login was more than 30 minutes ago', () async {
      // Arrange
      final oldTimestamp =
          DateTime.now().subtract(const Duration(minutes: 31)).toIso8601String();

      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(_lastLoginTimestampKey)).thenReturn(oldTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, true);
      verify(() => mockPrefs.getBool(_passcodeEnabledKey)).called(1);
      verify(() => mockPrefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should return false when last login was less than 30 minutes ago', () async {
      // Arrange
      final recentTimestamp =
          DateTime.now().subtract(const Duration(minutes: 29)).toIso8601String();

      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(_lastLoginTimestampKey)).thenReturn(recentTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
      verify(() => mockPrefs.getBool(_passcodeEnabledKey)).called(1);
      verify(() => mockPrefs.getString(_lastLoginTimestampKey)).called(1);
    });

    test('should throw StorageException when SharedPreferences throws an error',
        () async {
      // Arrange
      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenThrow(
        const StorageException(
          showUImessage: '',
          errorCode: ErrorCode.localStorageError,
          debugCode: 'error',
          methodName: '',
        ),
      );

      // Act & Assert
      expect(
        () => passcodeRepoImpl.shouldShowPasscode(),
        throwsA(isA<StorageException>()),
      );
    });

    test('should throw ServerException when timestamp parsing fails', () async {
      // Arrange
      when(() => mockPrefs.getBool(_passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(_lastLoginTimestampKey))
          .thenReturn('invalid_timestamp');

      // Act & Assert
      expect(
        () => passcodeRepoImpl.shouldShowPasscode(),
        throwsA(isA<UnknownException>()),
      );
    });
  });

  group('enableDisablePasscode', () {
    test('should enable passcode when it was disabled', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        final dateTimeNow = timeProvider.now().dateTime.toIso8601String();
        // Arrange
        when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);

        when(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true))
            .thenAnswer((_) async => true);

        when(() => mockPrefs.setString(StorageKeys.lastLoginTimestampKey, dateTimeNow))
            .thenAnswer((_) async => true);

        // Act
        await passcodeRepoImpl.enableDisablePasscode();

        //  Assert
        verifyInOrder([
          () => mockPrefs.reload(),
          () => mockPrefs.getBool(StorageKeys.passcodeEnabledKey),
          () => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true),
        ]);
      });
    });

    test('should disable passcode when it was enabled', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        // Arrange
        when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(true);

        when(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, false))
            .thenAnswer((_) async => true);

        when(() => mockPrefs.remove(StorageKeys.lastLoginTimestampKey))
            .thenAnswer((_) async => true);

        // Act
        await passcodeRepoImpl.enableDisablePasscode();

        // Assert
        verify(() => mockPrefs.reload()).called(1);

        verify(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, false)).called(1);
        verify(() => mockPrefs.remove(StorageKeys.lastLoginTimestampKey)).called(1);
      });
    });

    test('should enable passcode when current state is null', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        final dateTimeNow = timeProvider.now().dateTime.toIso8601String();
        // Arrange
        // Arrange
        when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(null);

        when(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true))
            .thenAnswer((_) async => true);

        when(() => mockPrefs.setString(StorageKeys.lastLoginTimestampKey, dateTimeNow))
            .thenAnswer((_) async => true);

        // Act
        await passcodeRepoImpl.enableDisablePasscode();

        //  Assert
        verifyInOrder([
          () => mockPrefs.reload(),
          () => mockPrefs.getBool(StorageKeys.passcodeEnabledKey),
          () => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true),
          () => mockPrefs.setString(StorageKeys.lastLoginTimestampKey, dateTimeNow),
        ]);
      });
    });

    test('should throw ServerException when SharedPreferences throws', () async {
      expect(
        () => passcodeRepoImpl.enableDisablePasscode(),
        throwsA(isA<StorageException>()),
      );
    });
  });

  group('verifyPasscode', () {
    const correctPasscode = 123456;
    const wrongPasscode = 567856;

    test('should return true when correct passcode is provided', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        final dateTime = timeProvider.currentTime;
        // Arrange
        await firestoreClient
            .collection(Strings.passcodeStoreCollection)
            .doc(Strings.passcodeStoreDocId)
            .set({
          Strings.appPasscode: correctPasscode,
        });

        when(
          () => mockPrefs.setString(
            StorageKeys.lastLoginTimestampKey,
            dateTime.toIso8601String(),
          ),
        ).thenAnswer((_) async => true);

        // Act
        final result = await passcodeRepoImpl.verifyPasscode(correctPasscode);

        // Assert
        expect(result, true);

        verify(
          () => mockPrefs.setString(
            StorageKeys.lastLoginTimestampKey,
            dateTime.toIso8601String(),
          ),
        ).called(1);
      });
    });

    test('should return false when incorrect passcode is provided', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.appPasscode: correctPasscode,
      });

      // Act
      final result = await passcodeRepoImpl.verifyPasscode(wrongPasscode);

      // Assert
      expect(result, false);
      verifyNever(() => mockPrefs.setString(any(), any()));
    });

    test('should throw ValidationException when passcode document does not exist',
        () async {
      // Arrange - not setting up any document in Firestore

      // Act & Assert
      expect(
        () => passcodeRepoImpl.verifyPasscode(correctPasscode),
        throwsA(
          allOf([
            isA<ValidationException>(),
          ]),
        ),
      );
    });

    test('should throw ValidationException when passcode field is missing', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        'some_other_field': 'some_value',
      });

      // Act & Assert
      expect(
        () => passcodeRepoImpl.verifyPasscode(correctPasscode),
        throwsA(
          allOf([isA<ValidationException>()]),
        ),
      );
    });

    test('should throw StorageException when SharedPreferences throws', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.appPasscode: correctPasscode,
      });

      when(() => mockPrefs.setString(any(), any())).thenThrow(
        const StorageException(
          showUImessage: 'Storage error',
          errorCode: ErrorCode.localStorageError,
          debugCode: 'error',
          methodName: 'VERIFY_PASSCODE',
        ),
      );

      // Act & Assert
      expect(
        () => passcodeRepoImpl.verifyPasscode(correctPasscode),
        throwsA(isA<StorageException>()),
      );
    });
  });
}
