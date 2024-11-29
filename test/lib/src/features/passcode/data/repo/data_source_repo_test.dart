// ignore_for_file: inference_failure_on_instance_creation

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/error/failure.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/features/passcode/data/repo/data_source_repo.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';

class MockPasscodeRemoteDataSource extends Mock implements PasscodeRemoteDataSource {}

void main() {
  late PasscodeRepositoryImpl repository;
  late MockPasscodeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockPasscodeRemoteDataSource();
    repository = PasscodeRepositoryImpl(mockRemoteDataSource);
  });

  group('setNewPasscode', () {
    const newPasscode = 1234;
    const confirmPasscode = 1234;
    const masterPasscode = 5678;

    test('should return Right(null) when the call to remote data source is successful',
        () async {
      // Arrange
      when(
        () => mockRemoteDataSource.setNewPasscode(
          newPasscode: any(named: 'newPasscode'),
          confirmPasscode: any(named: 'confirmPasscode'),
          masterPasscode: any(named: 'masterPasscode'),
        ),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      expect(result, equals(const Right(null)));
      verify(
        () => mockRemoteDataSource.setNewPasscode(
          newPasscode: newPasscode,
          confirmPasscode: confirmPasscode,
          masterPasscode: masterPasscode,
        ),
      ).called(1);
    });

    test(
        'should return Left(ServerFailure) when the call to remote data source throws a ServerException',
        () async {
      // Arrange
      when(
        () => mockRemoteDataSource.setNewPasscode(
          newPasscode: any(named: 'newPasscode'),
          confirmPasscode: any(named: 'confirmPasscode'),
          masterPasscode: any(named: 'masterPasscode'),
        ),
      ).thenThrow(const ServerException(message: 'Server Error', statusCode: '500'));

      // Act
      final result = await repository.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );

      // Assert
      expect(
        result,
        equals(const Left(ServerFailure(message: 'Server Error', statusCode: '500'))),
      );
    });
  });

  group('verifyPasscode', () {
    const passcode = 1234;

    test('should return Right(true) when the call to remote data source is successful',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.verifyPasscode(any()))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.verifyPasscode(passcode);

      // Assert
      expect(result, equals(const Right(true)));
      verify(() => mockRemoteDataSource.verifyPasscode(passcode)).called(1);
    });

    test(
        'should return Left(ServerFailure) when the call to remote data source throws a ServerException',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.verifyPasscode(any())).thenThrow(
        const ServerException(message: 'Verification Error', statusCode: '400'),
      );

      // Act
      final result = await repository.verifyPasscode(passcode);

      // Assert
      expect(
        result,
        equals(
          const Left(
            ServerFailure(message: 'Verification Error', statusCode: '400'),
          ),
        ),
      );
    });
  });

  group('enableDisablePasscode', () {
    test('should return Right(null) when the call to remote data source is successful',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.enableDisablePasscode())
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.enableDisablePasscode();

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.enableDisablePasscode()).called(1);
    });

    test(
        'should return Left(CacheFailure) when the call to remote data source throws a CacheException',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.enableDisablePasscode())
          .thenThrow(const CacheException(message: 'Cache Error', statusCode: '500'));

      // Act
      final result = await repository.enableDisablePasscode();

      // Assert
      expect(
        result,
        equals(const Left(CacheFailure(message: 'Cache Error', statusCode: '500'))),
      );
    });
  });

  group('shouldShowPasscode', () {
    test('should return Right(true) when the call to remote data source is successful',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.shouldShowPasscode()).thenAnswer((_) async => true);

      // Act
      final result = await repository.shouldShowPasscode();

      // Assert
      expect(result, equals(const Right(true)));
      verify(() => mockRemoteDataSource.shouldShowPasscode()).called(1);
    });

    test(
        'should return Left(ServerFailure) when the call to remote data source throws a ServerException',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.shouldShowPasscode())
          .thenThrow(const ServerException(message: 'Server Error', statusCode: '500'));

      // Act
      final result = await repository.shouldShowPasscode();

      // Assert
      expect(
        result,
        equals(const Left(ServerFailure(message: 'Server Error', statusCode: '500'))),
      );
    });


  });
}
