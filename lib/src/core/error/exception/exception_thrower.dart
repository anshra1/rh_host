import 'package:firebase_core/firebase_core.dart';
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/error/exception_formatter/error_fomatter.dart';
import 'package:rh_host/src/core/error/firebase_error/firebase_error_config.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';
import 'package:rh_host/src/core/system/storage/shared_pref_error_config.dart';

class ExceptionThrower {
  ExceptionThrower._();
  static Never throwUnknownExceptionWithFirebase({
    required dynamic error,
    required StackTrace stackTrace,
    required String methodName,
  }) {
    if (error is AppException) {
      throw error; // Rethrow if already an AppException
    }

    if (error is FirebaseException) {
      throw serverFirebaseException(
        error: error,
        stackTrace: stackTrace,
        methodName: methodName,
      );
    }

    throw unknownException(
      error: error,
      stackTrace: stackTrace,
      methodName: methodName,
    );
  }

  static Never throwExceptionWithCatch({
    required dynamic error,
    required StackTrace stackTrace,
    required String methodName,
  }) {
    if (error is AppException) {
      throw error; // Rethrow if already an AppException
    }

    throw unknownException(
      error: error,
      stackTrace: stackTrace,
      methodName: methodName,
    );
  }

  static Never serverFirebaseException({
    required FirebaseException error,
    required StackTrace stackTrace,
    required String methodName,
  }) {
    final serverity = FirebaseErrorConfig.getSeverity(error);
    final errorCode = FirebaseErrorConfig.getErrorCode(error);
    final isRecoverable = FirebaseErrorConfig.isRecoverable(error);

    final serverException = ServerException(
      errorCode: errorCode,
      debugCode: error.code,
      showUImessage: error.message ?? 'Firebase Error Occurred',
      debugDetails: error.stackTrace.toString(),
      severity: serverity,
      isRecoverable: isRecoverable,
      dartStackTrace: stackTrace,
      methodName: methodName,
    );
    DebugLogger.instance.error(serverException.toString(), error, stackTrace);
    throw serverException;
  }

  static Never unknownException({
    required dynamic error,
    required String methodName,
    StackTrace? stackTrace,
  }) {
    if (error is AppException) {
      throw error; // Rethrow if already an AppException
    }

    final unknownExcetion = UnknownException(
      debugCode: error,
      showUImessage: Strings.unknownError,
      dartStackTrace: stackTrace,
      errorCode: ErrorCode.unknown,
      methodName: methodName,
    );
    DebugLogger.instance.error(unknownExcetion.toString(), error, stackTrace);
    throw unknownExcetion;
  }

  static Never validationException({
    required dynamic debugCode,
    required String methodName,
    required String messsage,
  }) {
    final validationException = ValidationException(
      debugCode: debugCode,
      showUImessage: messsage,
      methodName: methodName,
      errorCode: ErrorCode.validation,
    );
    DebugLogger.instance.error(validationException.toString());
    throw validationException;
  }

  static Never sharedPrefanceException(
    dynamic error,
    StackTrace stackTrace, {
    required String methodName,
    required String fallbackMessage,
    ErrorSeverity? errorSeverity,
  }) {
    final storageDebugCode = SharedPrefErrorConfig.getStorageDebugCode(error);
    final severity = SharedPrefErrorConfig.getSeverity(storageDebugCode);
    final isRecoverable = SharedPrefErrorConfig.isRecoverable(storageDebugCode);
    final errorCode =
        SharedPrefErrorConfig.convertStorageErrorToErrorCode(storageDebugCode);
    final debugDetails = SharedPrefErrorConfig.getDebugErrorMessage(
      code: storageDebugCode,
      fallbackMessage: fallbackMessage,
    );
    final userUIMessage = SharedPrefErrorConfig.getUserMessage(errorCode);

    final storageException = StorageException(
      showUImessage: userUIMessage,
      debugDetails: debugDetails,
      debugCode: storageDebugCode.toString(),
      methodName: methodName,
      stackTrace: stackTrace,
      errorCode: errorCode,
      severity: errorSeverity ?? severity,
      isRecoverable: isRecoverable,
    );

    // Log full details for debugging
    DebugLogger.instance.error(
      ErrorFormatter.format(storageException, stackTrace),
    );

    throw storageException;
  }
}
