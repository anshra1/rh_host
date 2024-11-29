import 'package:rh_host/src/core/errror/error_codes.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/core/errror/failure.dart';

class ErrorMapper {
  static Failure mapErrorToFailure(dynamic error, [String? customMessage]) {

    if (error is ServerException) {
      return _mapServerError(error, customMessage);
    }

    if (error is NetworkException) {
      return NetworkFailure(
        message: _formatErrorMessage(
          customMessage,
          'Please check your internet connection',
        ),
        code: ErrorCode.noInternet,
      );
    }

    if (error is ValidationException) {
      return ValidationFailure(
        message: _formatErrorMessage(
          customMessage,
          error.message ?? 'Validation failed',
        ),
        code: ErrorCode.unknown,
      );
    }

    return ServerFailure(
      message: _formatErrorMessage(
        customMessage,
        'Something went wrong',
      ),
      code: ErrorCode.unknown,
    );
  }

  static Failure _mapServerError(
    ServerException error,
    String? customMessage,
  ) {
    switch (error.code) {
      case '4000':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Invalid request. Please check your input',
          ),
          code: ErrorCode.badRequest,
          category: error.category,
          severity: error.severity,
          isRecoverable: error.isRecoverable,
        );
      case '400':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Invalid request. Please check your input',
          ),
          code: ErrorCode.badRequest,
        );
      case '401':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Your session has expired. Please login again',
          ),
          code: ErrorCode.unauthorized,
        );
      case '403':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'You do not have permission to access this resource',
          ),
          code: ErrorCode.forbidden,
        );
      case '404':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Resource not found',
          ),
          code: ErrorCode.notFound,
        );
      case '500':
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Internal server error',
          ),
          code: ErrorCode.serverError,
        );
      case ErrorCode.notFoundPasscode:
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            'Passcode not found',
          ),
          code: ErrorCode.notFoundPasscode,
        );
      default:
        return ServerFailure(
          message: _formatErrorMessage(
            customMessage,
            error.message ?? 'Something went Wrong',
          ),
          code: ErrorCode.serverGeneric,
          category: error.category,
          severity: error.severity,
          isRecoverable: error.isRecoverable, 
        );
    }
  }

  // Helper method to format error messages
  static String _formatErrorMessage(String? customMessage, String defaultMessage) {
    if (customMessage == null || customMessage.isEmpty) {
      return defaultMessage;
    }
    // You can choose one of these formats:

    // Format 1: Custom Message: Default Message
    //  return '$customMessage: $defaultMessage';

    // Format 2: Custom Message (Default Message)
    // return '$customMessage ($defaultMessage)';

    // Format 3: Just Custom Message
    return customMessage;

    // Format 4: Default Message - Custom Message
    // return '$defaultMessage - $customMessage';
  }
}

