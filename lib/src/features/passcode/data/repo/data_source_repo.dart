import 'package:dartz/dartz.dart';
import 'package:rh_host/src/core/error/error_mapper.dart';
import 'package:rh_host/src/core/error/errror_system/error_handler.dart';
import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class PasscodeRepositoryImpl implements PasscodeRepo {
  PasscodeRepositoryImpl({
    required PasscodeRemoteDataSource remoteDataSource,
    required ErrorHandler errorHandler,
  })  : _remoteDataSource = remoteDataSource,
        _errorHandler = errorHandler;

  final PasscodeRemoteDataSource _remoteDataSource;
  final ErrorHandler _errorHandler;

  @override
  ResultFuture<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    try {
      await _errorHandler.handleWithRetry(
        operation: () async {
          await _remoteDataSource.setNewPasscode(
            newPasscode: newPasscode,
            confirmPasscode: confirmPasscode,
            masterPasscode: masterPasscode,
          );
        },
        context: 'set new passcode',
      );

      return const Right(null);
    } catch (e, s) {
      await _errorHandler.handleError(e, stackTrace: s);
      final failure = ErrorMapper.mapErrorToFailure(e);
      return Left(failure);
    }
  }

  @override
  ResultFuture<bool> verifyPasscode(int passcode) async {
    try {
      final result = await _errorHandler.handleWithRetry(
        operation: () => _remoteDataSource.verifyPasscode(passcode),
        context: 'verify passcode',
      );

      return Right(result);
    } catch (e, s) {
      await _errorHandler.handleError(e, stackTrace: s);
      final failure = ErrorMapper.mapErrorToFailure(e);
      return Left(failure);
    }
  }

  @override
  ResultFuture<void> enableDisablePasscode() async {
    // No initial network check needed as this operation primarily uses SharedPreferences
    try {
      await _errorHandler.handleWithRetry(
        operation: _remoteDataSource.enableDisablePasscode,
        context: 'enable/disable passcode',
      );
      return const Right(null);
    } catch (e, s) {
      await _errorHandler.handleError(e, stackTrace: s);
      final failure = ErrorMapper.mapErrorToFailure(e);
      return Left(failure);
    }
  }

  @override
  ResultFuture<bool> shouldShowPasscode() async {
    try {
      final result = await _remoteDataSource.shouldShowPasscode();
      return Right(result);
    } catch (e, s) {
      await _errorHandler.handleError(e, stackTrace: s);
      final failure = ErrorMapper.mapErrorToFailure(e);
      return Left(failure);
    }
  }
}
