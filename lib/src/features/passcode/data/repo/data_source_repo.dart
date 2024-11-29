import 'package:dartz/dartz.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/errror/error_codes.dart';
import 'package:rh_host/src/core/errror/error_handler.dart';
import 'package:rh_host/src/core/errror/error_mapper.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/core/errror/failure.dart';
import 'package:rh_host/src/core/network/network_info.dart';
import 'package:rh_host/src/core/typedef/typedef.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';

class PasscodeRepositoryImpl implements PasscodeRepo {
  PasscodeRepositoryImpl(
    this._remoteDataSource,
    this.errorHandler,
    this.networkInfo,
  );

  final PasscodeRemoteDataSource _remoteDataSource;
  final ErrorHandler errorHandler;
  final NetworkChecker networkInfo;

  @override
  ResultFuture<void> setNewPasscode({
    required int newPasscode,
    required int confirmPasscode,
    required int masterPasscode,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(
            message: 'Internet connection required to set passcode',
            code: ErrorCode.noInternet,
          ),
        );
      }

      await errorHandler.handleWithRetry(
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
      // Check if connection was lost during operation
      if (!await networkInfo.isConnected) {
        return const Left(
          NetworkFailure(
            message: 'Connection lost during operation',
            code: ErrorCode.connectionLost,
          ),
        );
      }

      await errorHandler.handleError(
        e,
        stackTrace: s,
        severity: ErrorSeverity.high,
      );

      final failure = ErrorMapper.mapErrorToFailure(e);
      return Left(failure);
    }
  }

  @override
  ResultFuture<bool> verifyPasscode(int passcode) async {
    try {
      final result = await _remoteDataSource.verifyPasscode(passcode);
      return Right(result);
    } on ServerException catch (e, s) {
      final ss = s;
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '500'));
    }
  }

  @override
  ResultFuture<void> enableDisablePasscode() async {
    try {
      await _remoteDataSource.enableDisablePasscode();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString(), statusCode: '500'));
    }
  }

  @override
  ResultFuture<bool> shouldShowPasscode() async {
    try {
      final result = await _remoteDataSource.shouldShowPasscode();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: '500'));
    }
  }
}
