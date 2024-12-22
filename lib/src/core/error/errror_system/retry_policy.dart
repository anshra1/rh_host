import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';

class RetryPolicy {
  const RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(milliseconds: 200),
    this.backoffFactor = 2.0,
    this.retryableCodes = const {
      ErrorCode.networkError,
      ErrorCode.timeOut,
      ErrorCode.serverError,
    },
    this.maxDelay = const Duration(seconds: 10),
    this.shouldRetry = true,
  });

  final int maxAttempts;
  final Duration initialDelay;
  final double backoffFactor;
  final Set<ErrorCode> retryableCodes;
  final Duration maxDelay;
  final bool shouldRetry;

  Future<T> execute<T>(Future<T> Function() operation) async {
    var attempts = 0;
    var currentDelay = initialDelay;

    while (true) {
      try {
        attempts++;
        return await operation();
      } catch (error) {
        if (!_shouldRetryError(error) || attempts >= maxAttempts) {
          rethrow;
        }

        await Future<void>.delayed(currentDelay);
        currentDelay = _nextDelay(currentDelay);
      }
    }
  }

  bool _shouldRetryError(dynamic error) {
    if (!shouldRetry) return false;
    if (error is AppException) {
      return retryableCodes.contains(error.debugCode);
    }
    return false;
  }

  Duration _nextDelay(Duration currentDelay) {
    final nextDelay = currentDelay * backoffFactor;
    return nextDelay > maxDelay ? maxDelay : nextDelay;
  }
}

class DefaultRetryPolicy extends RetryPolicy {
  DefaultRetryPolicy()
      : super(
          maxAttempts: 3,
          initialDelay: const Duration(milliseconds: 200),
          backoffFactor: 2,
          retryableCodes: const {
            ErrorCode.networkError,
            ErrorCode.timeOut,
            ErrorCode.serverError,
          },
          maxDelay: const Duration(seconds: 5),
        );
}
