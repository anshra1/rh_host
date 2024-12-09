// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:rh_host/src/core/error/error_mapper.dart';
import 'package:rh_host/src/core/error/errror_system/error_handler.dart';
import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class PasscodeRepositoryImpl implements PasscodeRepo {
  const PasscodeRepositoryImpl({
    required PasscodeRemoteDataSource remoteDataSource,
    required ErrorHandler errorHandler,
  })  : _remoteDataSource = remoteDataSource,
        _errorHandler = errorHandler;

  final PasscodeRemoteDataSource _remoteDataSource;
  final ErrorHandler _errorHandler;

  @override
  ResultFuture<bool> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    try {
      final result = await _remoteDataSource.setNewPasscode(
        newPasscode: newPasscode,
        confirmPasscode: confirmPasscode,
        masterPasscode: masterPasscode,
      );
      return Right(result);
    } catch (e, s) {
      await _errorHandler.handleError(
        e,
        stackTrace: s,
        context: 'PasscodeRepositoryImpl.setNewPasscode',
        additionalData: {
          'newPasscode': newPasscode.toString().length,
          'confirmPasscode': confirmPasscode.toString().length,
          // ignore: unnecessary_null_comparison
          'hasMasterPasscode': masterPasscode != null,
        },
      );
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<bool> verifyPasscode(int passcode) async {
    try {
      final isValid = await _remoteDataSource.verifyPasscode(passcode);
      return Right(isValid);
    } catch (e, s) {
      await _errorHandler.handleError(
        e,
        stackTrace: s,
        context: 'PasscodeRepositoryImpl.verifyPasscode',
        additionalData: {
          'passcodeLength': passcode.toString().length,
        },
      );
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<bool> enableDisablePasscode() async {
    try {
      final result = await _remoteDataSource.enableDisablePasscode();
      return Right(result);
    } catch (e, s) {
      await _errorHandler.handleError(
        e,
        stackTrace: s,
        context: 'PasscodeRepositoryImpl.enableDisablePasscode',
      );
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }

  @override
  ResultFuture<bool> shouldShowPasscode() async {
    try {
      final shouldShow = await _remoteDataSource.shouldShowPasscode();
      return Right(shouldShow);
    } catch (e, s) {
      await _errorHandler.handleError(
        e,
        stackTrace: s,
        context: 'PasscodeRepositoryImpl.shouldShowPasscode',
      );
      return Left(ErrorMapper.mapErrorToFailure(e));
    }
  }
}
