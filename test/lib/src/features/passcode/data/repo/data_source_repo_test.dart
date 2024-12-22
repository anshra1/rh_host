// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_function_invocation

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/error/errror_system/error_handler.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';
import 'package:rh_host/src/features/passcode/data/repo/data_source_repo.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';

class MockPasscodeRemoteDataSource extends Mock implements PasscodeRemoteDataSource {}

class MockErrorHandler extends Mock implements ErrorHandler {}

void main() {
  late PasscodeRepositoryImpl repository;
  late MockPasscodeRemoteDataSource mockRemoteDataSource;
  late MockErrorHandler mockErrorHandler;

  setUp(() {
    mockRemoteDataSource = MockPasscodeRemoteDataSource();
    mockErrorHandler = MockErrorHandler();
    repository = PasscodeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      errorHandler: mockErrorHandler,
    );
    registerFallbackValue(StackTrace.empty);
  });

  const tNewPasscode = 123456;
  const tConfirmPasscode = 123456;
  const tMasterPasscode = 999999;

  group('setNewPasscode', () {
    test(
      'should return Right(true) when remote data source successfully sets passcode',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.setNewPasscode(
            newPasscode: any(named: 'newPasscode'),
            confirmPasscode: any(named: 'confirmPasscode'),
            masterPasscode: any(named: 'masterPasscode'),
          ),
        ).thenAnswer((_) async => true);

        // Act
        final result = await repository.setNewPasscode(
          newPasscode: tNewPasscode,
          confirmPasscode: tConfirmPasscode,
          masterPasscode: tMasterPasscode,
        );

        // Assert
        expect(result, equals(const Right<Failure, bool>(true)));
        verify(
          () => mockRemoteDataSource.setNewPasscode(
            newPasscode: tNewPasscode,
            confirmPasscode: tConfirmPasscode,
            masterPasscode: tMasterPasscode,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      "should return Right(false) when remote data source fails to set passcode but doesn't throw",
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.setNewPasscode(
            newPasscode: any(named: 'newPasscode'),
            confirmPasscode: any(named: 'confirmPasscode'),
            masterPasscode: any(named: 'masterPasscode'),
          ),
        ).thenAnswer((_) async => false);

        // Act
        final result = await repository.setNewPasscode(
          newPasscode: tNewPasscode,
          confirmPasscode: tConfirmPasscode,
          masterPasscode: tMasterPasscode,
        );

        // Assert
        expect(result, equals(const Right<Failure, bool>(false)));
        verify(
          () => mockRemoteDataSource.setNewPasscode(
            newPasscode: tNewPasscode,
            confirmPasscode: tConfirmPasscode,
            masterPasscode: tMasterPasscode,
          ),
        ).called(1);
      },
    );

    test(
      'should return Left(Failure) when remote data source throws an exception',
      () async {
        // Arrange
        final tException = Exception('Test error');
        when(
          () => mockRemoteDataSource.setNewPasscode(
            newPasscode: any(named: 'newPasscode'),
            confirmPasscode: any(named: 'confirmPasscode'),
            masterPasscode: any(named: 'masterPasscode'),
          ),
        ).thenThrow(tException);

        when(
          () => mockErrorHandler.handleError(
            any(),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
            additionalData: any(named: 'additionalData'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.setNewPasscode(
          newPasscode: tNewPasscode,
          confirmPasscode: tConfirmPasscode,
          masterPasscode: tMasterPasscode,
        );

        // Assert
        expect(result.isLeft(), true);
        verify(
          () => mockErrorHandler.handleError(
            tException,
            stackTrace: any(named: 'stackTrace'),
            context: 'PasscodeRepositoryImpl.setNewPasscode',
            additionalData: any(named: 'additionalData'),
          ),
        ).called(1);
      },
    );
  });

  group('verifyPasscode', () {
    const tPasscode = 123456;

    test(
      'should return Right(true) when passcode verification is successful',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.verifyPasscode(any()))
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.verifyPasscode(tPasscode);

        // Assert
        expect(result, equals(const Right<Failure, bool>(true)));
        verify(() => mockRemoteDataSource.verifyPasscode(tPasscode)).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      "should return Right(false) when passcode verification fails but doesn't throw",
      () async {
        // Arrange
        when(() => mockRemoteDataSource.verifyPasscode(any()))
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.verifyPasscode(tPasscode);

        // Assert
        expect(result, equals(const Right<Failure, bool>(false)));
        verify(() => mockRemoteDataSource.verifyPasscode(tPasscode)).called(1);
      },
    );

    test(
      'should return Left(Failure) when remote data source throws an exception',
      () async {
        // Arrange
        final tException = Exception('Test error');
        when(() => mockRemoteDataSource.verifyPasscode(any())).thenThrow(tException);

        when(
          () => mockErrorHandler.handleError(
            any(),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
            additionalData: any(named: 'additionalData'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.verifyPasscode(tPasscode);

        // Assert
        expect(result.isLeft(), true);
        verify(
          () => mockErrorHandler.handleError(
            tException,
            stackTrace: any(named: 'stackTrace'),
            context: 'PasscodeRepositoryImpl.verifyPasscode',
            additionalData: any(named: 'additionalData'),
          ),
        ).called(1);
      },
    );
  });

  group('enableDisablePasscode', () {
    test(
      'should return Right(true) when successfully enabling passcode',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.enableDisablePasscode())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.enableDisablePasscode();

        // Assert
        expect(result, equals(const Right<Failure, bool>(true)));
        verify(() => mockRemoteDataSource.enableDisablePasscode()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Right(false) when successfully disabling passcode',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.enableDisablePasscode())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.enableDisablePasscode();

        // Assert
        expect(result, equals(const Right<Failure, bool>(false)));
        verify(() => mockRemoteDataSource.enableDisablePasscode()).called(1);
      },
    );

    test(
      'should return Left(Failure) when enabling/disabling throws an exception',
      () async {
        // Arrange
        final tException = Exception('Test error');
        when(() => mockRemoteDataSource.enableDisablePasscode()).thenThrow(tException);

        when(
          () => mockErrorHandler.handleError(
            any(),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.enableDisablePasscode();

        // Assert
        expect(result.isLeft(), true);
        verify(
          () => mockErrorHandler.handleError(
            tException,
            stackTrace: any(named: 'stackTrace'),
            context: 'PasscodeRepositoryImpl.enableDisablePasscode',
          ),
        ).called(1);
      },
    );
  });

  group('shouldShowPasscode', () {
    test(
      'should return Right(true) when passcode should be shown',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.shouldShowPasscode())
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.shouldShowPasscode();

        // Assert
        expect(result, equals(const Right<Failure, bool>(true)));
        verify(() => mockRemoteDataSource.shouldShowPasscode()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Right(false) when passcode should not be shown',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.shouldShowPasscode())
            .thenAnswer((_) async => false);

        // Act
        final result = await repository.shouldShowPasscode();

        // Assert
        expect(result, equals(const Right<Failure, bool>(false)));
        verify(() => mockRemoteDataSource.shouldShowPasscode()).called(1);
      },
    );

    test(
      'should return Left(Failure) when checking throws an exception',
      () async {
        // Arrange
        final tException = Exception('Test error');
        when(() => mockRemoteDataSource.shouldShowPasscode()).thenThrow(tException);

        when(
          () => mockErrorHandler.handleError(
            any(),
            stackTrace: any(named: 'stackTrace'),
            context: any(named: 'context'),
          ),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.shouldShowPasscode();

        // Assert
        expect(result.isLeft(), true);
        verify(
          () => mockErrorHandler.handleError(
            tException,
            stackTrace: any(named: 'stackTrace'),
            context: 'PasscodeRepositoryImpl.shouldShowPasscode',
          ),
        ).called(1);
      },
    );
  });
}
