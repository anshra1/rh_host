// Project imports:
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';
import 'package:rh_host/src/core/constants/string.dart';

class ErrorMapper {
  static Failure mapErrorToFailure(dynamic error) {
    // Since exceptions already have proper messages and codes,
    // we just need to map them directly

     if (error is AppException) {
      return ServerFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }


    if (error is ServerException) {
      return ServerFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }

    // Validation Exceptions
    if (error is ValidationException) {
      return ValidationFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }

    // Network Exceptions
    if (error is NetworkException) {
      return NetworkFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }

    // Cache Exceptions
    if (error is CacheException) {
      return CacheFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }

    if (error is StorageException) {
      return StoreageFailure(
        message: error.showUImessage ?? Strings.unknownError,
        code: error.errorCode,
        category: error.category,
        isRecoverable: error.isRecoverable,
        severity: error.severity,
      );
    }

    // Unknown/Unexpected Errors
    return const UnknownFailure(
      message: Strings.unknownError,
      code: ErrorCode.unknown,
      category: ErrorCategory.unknown,
      isRecoverable: false,
      severity: ErrorSeverity.low,
    );
  }
}
