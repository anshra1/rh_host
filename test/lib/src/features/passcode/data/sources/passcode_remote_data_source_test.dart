// ignore_for_file: lines_longer_than_80_chars, no_leading_underscores_for_local_identifiers, avoid_print

// Package imports:
import 'package:clock/clock.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Project imports:
import 'package:rh_host/src/core/presentation/constants/string.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/errror_system/retry_policy.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/system/clock/clock_provider.dart';
import 'package:rh_host/src/core/system/clock/time_config.dart';
import 'package:rh_host/src/core/system/network/network_info.dart';
import 'package:rh_host/src/core/system/storage/shared_pref_storage.dart';
import 'package:rh_host/src/core/system/storage/storage_keys.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockNetworkCheckerImpl extends Mock implements NetworkCheckerImpl {}

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late MockSharedPreferences mockPrefs;
  late SharedPrefsStorages sharedPrefsStorage;
  late PasscodeRemoteDataSourceImpl passcodeRepoImpl;
  late TimeProvider timeProvider;
  late MockNetworkCheckerImpl mockNetworkChecker;

  setUp(() async {
    mockNetworkChecker = MockNetworkCheckerImpl();
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.reload()).thenAnswer((_) async {});
    sharedPrefsStorage = SharedPrefsStorages(prefs: mockPrefs);
    firestoreClient = FakeFirebaseFirestore();
    timeProvider = const TimeProvider(config: TimeConfig());

    passcodeRepoImpl = PasscodeRemoteDataSourceImpl(
      firestoreClient: firestoreClient,
      prefs: sharedPrefsStorage,
      timeProvider: timeProvider,
      networkCheckerImpl: mockNetworkChecker,
      retryPolicy: const RetryPolicy(),
    );

    when(() => mockNetworkChecker.isConnected).thenAnswer((_) async => true);
  });

  tearDown(() {
    reset(mockPrefs);
  });

  group('setNewPasscode', () {
    const newPasscode = 123456;
    const confirmPasscode = 123456;
    const masterPasscode = 567890;

    test('should successfully set new passcode and return true', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.setMasterPasscode: masterPasscode,
      });

      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);
      when(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true))
          .thenAnswer((_) async => true);
      when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

      // Act
      final result = await passcodeRepoImpl.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      expect(result, true);
      final docSnapshot = await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .get();
      expect(docSnapshot.data()?[Strings.appPasscode], newPasscode);
      verify(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true)).called(1);
    });

    test('should return false when SharedPreferences operations fail', () async {
      // Arrange
      await firestoreClient
          .collection(Strings.passcodeStoreCollection)
          .doc(Strings.passcodeStoreDocId)
          .set({
        Strings.setMasterPasscode: masterPasscode,
      });

      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);
      when(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true))
          .thenAnswer((_) async => false);

      // Act
      final result = await passcodeRepoImpl.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      expect(result, false);
    });

    test('should throw ValidationException when passcodes mismatch', () async {
      // Act & Assert
      expect(
        () => passcodeRepoImpl.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: 654321,
          masterPasscode: masterPasscode,
        ),
        throwsA(
          allOf([
            isA<ValidationException>(),
            predicate<ValidationException>(
              (e) => e.showUImessage == Strings.invalidMasterPasscode,
            ),
            predicate<ValidationException>((e) => e.errorCode == ErrorCode.validation),
            predicate<ValidationException>((e) => e.severity == ErrorSeverity.low),
          ]),
        ),
      );
    });
  });

  group('verifyPasscode', () {
    const correctPasscode = 123456;
    const wrongPasscode = 654321;

    test('should return true for correct passcode', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        // Arrange
        await firestoreClient
            .collection(Strings.passcodeStoreCollection)
            .doc(Strings.passcodeStoreDocId)
            .set({
          Strings.appPasscode: correctPasscode,
        });

        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

        // Act
        final result = await passcodeRepoImpl.verifyPasscode(correctPasscode);

        // Assert
        expect(result, true);
        verify(() => mockPrefs.setString(any(), any())).called(1);
      });
    });

    test('should return false for incorrect passcode', () async {
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
  });

  group('enableDisablePasscode', () {
    test('should return true when enabling passcode', () async {
      await withClock(Clock.fixed(DateTime(2024)), () async {
        // Arrange
        when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);
        when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);
        when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

        // Act
        final result = await passcodeRepoImpl.enableDisablePasscode();

        // Assert
        expect(result, true);
        verify(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, true)).called(1);
      });
    });

    test('should return false when disabling passcode', () async {
      // Arrange
      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.setBool(any(), any())).thenAnswer((_) async => true);
      when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);

      // Act
      final result = await passcodeRepoImpl.enableDisablePasscode();

      // Assert
      expect(result, false);
      verify(() => mockPrefs.setBool(StorageKeys.passcodeEnabledKey, false)).called(1);
      verify(() => mockPrefs.remove(StorageKeys.lastLoginTimestampKey)).called(1);
    });
  });

  group('shouldShowPasscode', () {
    test('should return false when passcode is disabled', () async {
      // Arrange
      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(false);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
    });

    test('should return true when last login was more than 30 minutes ago', () async {
      // Arrange
      final oldTimestamp =
          DateTime.now().subtract(const Duration(minutes: 31)).toIso8601String();

      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(StorageKeys.lastLoginTimestampKey))
          .thenReturn(oldTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, true);
    });

    test('should return false when last login was less than 30 minutes ago', () async {
      // Arrange
      final recentTimestamp =
          DateTime.now().subtract(const Duration(minutes: 29)).toIso8601String();

      when(() => mockPrefs.getBool(StorageKeys.passcodeEnabledKey)).thenReturn(true);
      when(() => mockPrefs.getString(StorageKeys.lastLoginTimestampKey))
          .thenReturn(recentTimestamp);

      // Act
      final result = await passcodeRepoImpl.shouldShowPasscode();

      // Assert
      expect(result, false);
    });
  });
}
