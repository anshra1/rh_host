// Project imports:
import 'package:rh_host/src/core/error/exception/exception_thrower.dart';
import 'package:rh_host/src/core/system/storage/shared_pref_error_config.dart';
import 'package:rh_host/src/core/system/storage/storage_context.dart';

class StorageRetryManager {
  const StorageRetryManager._();

  static Future<T> withRetry<T>({
    required Future<T> Function() operation,
    required String methodName,
    required String fallbackMessage,
    StorageErrorContext? context,
    int maxRetries = 2,
  }) async {
    var currentAttempt = 1;

    while (true) {
      try {
        return await operation();
      } catch (error, stackTrace) {
        final storageErrorCode = SharedPrefErrorConfig.getStorageDebugCode(error);
        final retryStrategy = SharedPrefErrorConfig.getRetryStrategy(storageErrorCode);

        if (!retryStrategy.shouldRetry || currentAttempt >= maxRetries) {
          throw ExceptionThrower.sharedPrefanceException(
            error, // Use the original error rethow in method
            stackTrace, // Use the original stack trace method
            methodName: '$methodName (Attempt $currentAttempt of $maxRetries)',
            fallbackMessage:
                '$fallbackMessage (After $currentAttempt ${currentAttempt == 1 ? 'try' : 'tries'})',
          );
        }

        // Wait before retrying
        await Future<void>.delayed(retryStrategy.retryDelay);
        currentAttempt++;
      }
    }
  }
}
