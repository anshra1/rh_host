// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/enum/storage_codes.dart';
import 'package:rh_host/src/core/system/storage/retry_strategy.dart';
import 'package:rh_host/src/core/system/storage/storage_context.dart';

class SharedPrefErrorConfig {
  static SharedPrefCode getStorageDebugCode(dynamic error) {
    // Type Errors
    if (error is TypeError) {
      return SharedPrefCode.typeError;
    }

    // Platform/OS Errors
    if (error is PlatformException) {
      switch (error.code) {
        case 'ERROR_DISK_FULL':
        case 'E_DISKFULL':
        case 'no_space':
          return SharedPrefCode.diskError;

        case 'ERROR_PERMISSION_DENIED':
        case 'E_NOPERM':
        case 'permission_denied':
          return SharedPrefCode.permissionError;

        case 'ERROR_INITIALIZATION_FAILED':
        case 'E_INIT':
          return SharedPrefCode.initError;

        default:
          return SharedPrefCode.unknown;
      }
    }

    // SharedPreferences Specific Errors
    if (error is StateError) {
      if (error.message.contains('not initialized')) {
        return SharedPrefCode.initError;
      }
      return SharedPrefCode.stateError;
    }

    // File System Errors
    if (error is FileSystemException) {
      switch (error.osError?.errorCode) {
        case 13: // Permission denied
          return SharedPrefCode.permissionError;
        case 28: // No space left on device
          return SharedPrefCode.diskError;
        case 2: // No such file or directory
          return SharedPrefCode.notFound;
        default:
          return SharedPrefCode.fileSystemError;
      }
    }

    // Format Errors
    if (error is FormatException) {
      return SharedPrefCode.formatError;
    }

    // JSON Errors
    if (error.toString().contains('JsonUnsupportedObjectError')) {
      return SharedPrefCode.serializationError;
    }

    // Other Common Errors
    if (error is ArgumentError) {
      return SharedPrefCode.invalidArgument;
    }

    if (error is UnsupportedError) {
      return SharedPrefCode.unsupportedOperation;
    }

    if (error is RangeError) {
      return SharedPrefCode.rangeError;
    }

    // System Level Errors
    if (error.toString().contains('Unable to allocate memory')) {
      return SharedPrefCode.outOfMemory;
    }

    if (error.toString().contains('Concurrent modification')) {
      return SharedPrefCode.concurrencyError;
    }

    // If nothing matches
    return SharedPrefCode.unknown;
  }

  static String getDebugErrorMessage({
    required SharedPrefCode code,
    String? fallbackMessage,
  }) {
    switch (code) {
      case SharedPrefCode.readError:
        return 'Failed to read data';
      case SharedPrefCode.writeError:
        return 'Failed to save data';
      case SharedPrefCode.typeError:
        return 'Data type mismatch';
      case SharedPrefCode.notFound:
        return 'Data not found';
      case SharedPrefCode.permissionError:
        return 'Permission denied to access storage';
      case SharedPrefCode.initError:
        return 'Failed to initialize storage';
      case SharedPrefCode.diskError:
        return 'Storage space is full';
      case SharedPrefCode.stateError:
        return 'Invalid storage state';
      case SharedPrefCode.fileSystemError:
        return 'File system error occurred';
      case SharedPrefCode.formatError:
        return 'Invalid data format';
      case SharedPrefCode.serializationError:
        return 'Failed to process data structure';
      case SharedPrefCode.invalidArgument:
        return 'Invalid input provided';
      case SharedPrefCode.unsupportedOperation:
        return 'Operation not supported';
      case SharedPrefCode.rangeError:
        return 'Value out of valid range';
      case SharedPrefCode.outOfMemory:
        return 'Insufficient memory';
      case SharedPrefCode.concurrencyError:
        return 'Concurrent modification error';
      case SharedPrefCode.unknown:
        return fallbackMessage ?? 'An unexpected error occurred';
    }
  }

  static ErrorSeverity getSeverity(SharedPrefCode code) {
    switch (code) {
      // High severity - Critical errors that prevent core functionality
      case SharedPrefCode.initError:
      case SharedPrefCode.permissionError:
      case SharedPrefCode.diskError:
      case SharedPrefCode.outOfMemory:
        return ErrorSeverity.high;

      // Medium severity - Errors that affect functionality but might be recoverable
      case SharedPrefCode.readError:
      case SharedPrefCode.writeError:
      case SharedPrefCode.fileSystemError:
      case SharedPrefCode.serializationError:
      case SharedPrefCode.concurrencyError:
        return ErrorSeverity.medium;

      // Low severity - Minor issues that don't significantly impact functionality
      case SharedPrefCode.typeError:
      case SharedPrefCode.formatError:
      case SharedPrefCode.invalidArgument:
      case SharedPrefCode.rangeError:
      case SharedPrefCode.unsupportedOperation:
      case SharedPrefCode.stateError:
        return ErrorSeverity.low;

      // Not found is typically low severity as it's an expected scenario
      case SharedPrefCode.notFound:
        return ErrorSeverity.low;

      // Default to medium severity for unknown errors
      case SharedPrefCode.unknown:
        return ErrorSeverity.medium;
    }
  }

  static bool isRecoverable(SharedPrefCode code) {
    switch (code) {
      // Non-recoverable errors
      case SharedPrefCode.initError:
      case SharedPrefCode.permissionError:
      case SharedPrefCode.outOfMemory:
        return false;

      // All other errors might be recoverable
      case SharedPrefCode.readError:
      case SharedPrefCode.writeError:
      case SharedPrefCode.typeError:
      case SharedPrefCode.notFound:
      case SharedPrefCode.diskError:
      case SharedPrefCode.stateError:
      case SharedPrefCode.fileSystemError:
      case SharedPrefCode.formatError:
      case SharedPrefCode.serializationError:
      case SharedPrefCode.invalidArgument:
      case SharedPrefCode.unsupportedOperation:
      case SharedPrefCode.rangeError:
      case SharedPrefCode.concurrencyError:
      case SharedPrefCode.unknown:
        return true;
    }
  }

  static ErrorCode convertStorageErrorToErrorCode(SharedPrefCode storageCode) {
    return switch (storageCode) {
      // Storage Full - User needs to free up space
      SharedPrefCode.diskError ||
      SharedPrefCode.outOfMemory =>
        ErrorCode.storageFull,

      // Permission Issues - User needs to grant permission
      SharedPrefCode.permissionError => ErrorCode.storagePermission,

      // App needs restart
      SharedPrefCode.initError ||
      SharedPrefCode.stateError ||
      SharedPrefCode.concurrencyError =>
        ErrorCode.appRestart,

      // Data corruption - User needs to clear data/reinstall
      SharedPrefCode.formatError ||
      SharedPrefCode.serializationError ||
      SharedPrefCode.fileSystemError =>
        ErrorCode.appDataCorrupted,

      // All other technical errors - Generic message
      SharedPrefCode.readError ||
      SharedPrefCode.writeError ||
      SharedPrefCode.typeError ||
      SharedPrefCode.notFound ||
      SharedPrefCode.invalidArgument ||
      SharedPrefCode.unsupportedOperation ||
      SharedPrefCode.rangeError ||
      SharedPrefCode.unknown =>
        ErrorCode.localStorageError,
    };
  }

  // static String getUserMessage(ErrorCode code) {
  //   return switch (code) {
  //     ErrorCode.storageFull =>
  //       'Your device storage is full. Please free up some space and try again',
  //     ErrorCode.storagePermission =>
  //       'Please allow storage access in your device settings',
  //     ErrorCode.appRestart => 'Please restart the app and try again',
  //     ErrorCode.appDataCorrupted => 'Please clear app data or reinstall the app',
  //     ErrorCode.localStorageError => 'An unexpected error occurred',
  //     _ => 'An unexpected error occurred'
  //   };
  // }

  static String getUserMessage(
    ErrorCode code, {
    StorageErrorContext? context,
  }) {
    final baseMessage = switch (code) {
      ErrorCode.storageFull =>
        'Your device storage is full. Please free up some space and try again',
      ErrorCode.storagePermission =>
        'Please allow storage access in your device settings',
      ErrorCode.appRestart => 'Please restart the app and try again',
      ErrorCode.appDataCorrupted =>
        'Please clear app data or reinstall the app',
      ErrorCode.localStorageError => 'An unexpected error occurred',
      _ => 'An unexpected error occurred'
    };

    // Add context if available
    if (context != null && context.operation != null) {
      return 'Error while ${context.operation}: $baseMessage';
    }

    return baseMessage;
  }

  static RetryStrategy getRetryStrategy(SharedPrefCode code) {
    return switch (code) {
      // No retry for these errors as they need user action
      SharedPrefCode.diskError ||
      SharedPrefCode.permissionError ||
      SharedPrefCode.outOfMemory =>
        const RetryStrategy(
          shouldRetry: false,
          retryCount: 0,
          retryDelay: Duration.zero,
        ),

      // Quick retry for transient errors
      SharedPrefCode.concurrencyError ||
      SharedPrefCode.stateError =>
        const RetryStrategy(
          shouldRetry: true,
          retryCount: 3,
          retryDelay: Duration(milliseconds: 100),
        ),

      // Slower retry for system errors
      SharedPrefCode.fileSystemError ||
      SharedPrefCode.initError =>
        const RetryStrategy(
          shouldRetry: true,
          retryCount: 2,
          retryDelay: Duration(seconds: 1),
        ),

      // Default strategy
      _ => const RetryStrategy(
          shouldRetry: false,
          retryCount: 0,
          retryDelay: Duration.zero,
        ),
    };
  }
}
