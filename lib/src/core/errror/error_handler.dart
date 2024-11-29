import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rh_host/src/core/enum/%20error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/errror/error_details.dart';
import 'package:rh_host/src/core/errror/exception.dart';
import 'package:rh_host/src/core/errror/retry_policy.dart';

class ErrorHandler {
  ErrorHandler({
    required Logger logger,
    required FirebaseAnalytics analytics,
    required FirebaseCrashlytics crashlytics,
    RetryPolicy? retryPolicy,
  })  : _logger = logger,
        _analytics = analytics,
        _crashlytics = crashlytics,
        _retryPolicy = retryPolicy ?? DefaultRetryPolicy();

  final Logger _logger;
  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;
  final RetryPolicy _retryPolicy;

  // Caching and batching
  static final Map<String, String> _errorMessageCache = {};
  static final Map<String, ErrorDetails> _errorDetailsCache = {};
  final List<ErrorDetails> _analyticsQueue = [];
  static const int _analyticsBatchSize = 10;

  Future<T> handleWithRetry<T>({
    required Future<T> Function() operation,
    required String context,
    RetryPolicy? customRetryPolicy,
    ErrorSeverity minimumSeverity = ErrorSeverity.medium,
  }) async {
    final policy = customRetryPolicy ?? _retryPolicy;
    try {
      return await policy.execute(operation);
    } catch (error, stackTrace) {
      if (_shouldProcess(error, minimumSeverity)) {
        await handleError(
          error,
          stackTrace: stackTrace,
          context: context,
          severity: minimumSeverity,
        );
      }
      rethrow;
    }
  }

  Future<void> handleError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
    ErrorSeverity severity = ErrorSeverity.medium,
  }) async {
    try {
      if (_isFastPathError(error)) {
        await _handleFastPathError(error);
        return;
      }

      if (!kDebugMode) {
        // Enrich and sanitize error data
        final enrichedData = await _enrichErrorData(additionalData);
        final sanitizedData = _sanitizeErrorData(enrichedData);

        // Process error details
        final errorDetails = _processError(
          error,
          context,
          sanitizedData,
          severity,
        );

        // Handle offline logging
        await _logOfflineError(errorDetails, stackTrace);

        // Parallel processing for non-critical operations
        await Future.wait([
          if (severity.value >= ErrorSeverity.medium.value)
            _logError(errorDetails, stackTrace),
          _queueAnalytics(errorDetails),
          if (_shouldReportToCrashlytics(errorDetails))
            _reportToCrashlytics(errorDetails, stackTrace),
        ]);
      }
    } catch (e, s) {
      // Fallback error handling
      _logger.f(
        'Error in error handler',
        error: e,
        stackTrace: s,
      );
    }
  }

  bool _shouldProcess(dynamic error, ErrorSeverity minimumSeverity) {
    if (error is ValidationException) return false;
    if (minimumSeverity == ErrorSeverity.low) return false;
    return true;
  }

  bool _isFastPathError(dynamic error) {
    return error is ValidationException ||
        error is NetworkTimeOutException ||
        error is CacheException;
  }

  Future<void> _handleFastPathError(dynamic error) async {
    final cachedMessage = _errorMessageCache[error.runtimeType.toString()];

    // Currently using debug level (_logger.d)
    if (cachedMessage != null) {
      // Should use info level since these are known/cached errors
      _logger.i(cachedMessage, error: error); // Changed from _logger.d to _logger.i
      return;
    }

    final message = _getQuickErrorMessage(error);
    _errorMessageCache[error.runtimeType.toString()] = message;

    // Log based on error type
    if (error is ValidationException) {
      _logger.i(message); // Info level - validation errors are expected
    } else if (error is NetworkTimeOutException || error is CacheException) {
      _logger.w(message); // Warning level - might need attention
    } else {
      _logger.d(message); // Debug level - unexpected cases
    }
  }

  String _getQuickErrorMessage(dynamic error) {
    if (error is ValidationException) {
      return 'Validation error occurred'; // Info level
    }
    if (error is NetworkTimeOutException) {
      return 'Network timeout'; // Warning level
    }
    if (error is CacheException) {
      return 'Cache error occurred'; // Warning level
    }
    return 'An error occurred'; // Debug level
  }

  Future<Map<String, dynamic>> _enrichErrorData(
    Map<String, dynamic>? additionalData,
  ) async {
    final packageInfo = await PackageInfo.fromPlatform();

    return {
      ...?additionalData,
      'app_version': packageInfo.version,
      'build_number': packageInfo.buildNumber,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> _sanitizeErrorData(Map<String, dynamic> data) {
    // Remove sensitive data
    final sanitized = Map<String, dynamic>.from(data);
    _sensitiveKeys.forEach(sanitized.remove);
    return sanitized;
  }

  static const _sensitiveKeys = [
    'password',
    'token',
    'secret',
    'credit_card',
    'ssn',
  ];

  Future<void> _logOfflineError(
    ErrorDetails errorDetails,
    StackTrace? stackTrace,
  ) async {
    // try {
    //   final box = await Hive.openBox<Map>('error_logs');
    //   await box.add({
    //     ...errorDetails.toMap(),
    //     'stackTrace': stackTrace?.toString(),
    //   });
    // } catch (e) {
    //   _logger.error('Failed to log error offline', error: e);
    // }
  }

  Future<void> _queueAnalytics(ErrorDetails details) async {
    _analyticsQueue.add(details);

    if (_analyticsQueue.length >= _analyticsBatchSize) {
      await _flushAnalyticsQueue();
    }
  }

  Future<void> _flushAnalyticsQueue() async {
    if (_analyticsQueue.isEmpty) return;

    final batchedDetails = _analyticsQueue.map((e) => e.toMap()).toList();
    await _analytics.logEvent(
      name: 'batch_errors',
      parameters: {'errors': batchedDetails},
    );
    _analyticsQueue.clear();
  }

  ErrorDetails _processError(
    dynamic error,
    String? context,
    Map<String, dynamic>? additionalData,
    ErrorSeverity severity,
  ) {
    final cacheKey = '${error.runtimeType}:${context ?? ""}';

    if (_errorDetailsCache.containsKey(cacheKey)) {
      return _errorDetailsCache[cacheKey]!.copyWith(
        additionalData: additionalData,
        timestamp: DateTime.now(),
      );
    }

    final details = error is AppException
        ? ErrorDetails.fromException(error, context, additionalData)
        : ErrorDetails.fromDynamic(error, context, additionalData);

    if (_shouldCacheErrorDetails(details)) {
      _errorDetailsCache[cacheKey] = details;
    }

    return details;
  }

  bool _shouldCacheErrorDetails(ErrorDetails details) {
    return details.severity != ErrorSeverity.fatal &&
        details.category != ErrorCategory.unknown;
  }

  Future<void> _logError(ErrorDetails details, StackTrace? stackTrace) async {
    _logger.f(
      details.message,
      error: details.originalError,
      stackTrace: stackTrace,
    );
  }

  Future<void> _reportToCrashlytics(
    ErrorDetails details,
    StackTrace? stackTrace,
  ) async {
    await _crashlytics.recordError(
      details.originalError,
      stackTrace,
      reason: details.message,
      fatal: details.severity == ErrorSeverity.fatal,
    );
  }

  bool _shouldReportToCrashlytics(ErrorDetails details) {
    if (details.severity == ErrorSeverity.low) return false;
    if (details.category == ErrorCategory.validation) return false;
    if (details.category == ErrorCategory.network &&
        details.severity != ErrorSeverity.fatal) return false;
    return true;
  }
}

// Example usage:
void main() {
  final errorHandler = ErrorHandler(
    logger: Logger(),
    analytics: FirebaseAnalytics.instance,
    crashlytics: FirebaseCrashlytics.instance,
  );
}

// Using in a repository
class ExampleRepository {
  late final ErrorHandler errorHandler;

  Future<void> performOperation() async {
    try {
      // Your operation here
    } catch (error, stackTrace) {
      await errorHandler.handleError(
        error,
        stackTrace: stackTrace,
        context: 'ExampleRepository.performOperation',
        additionalData: {'operationType': 'example'},
      );
      rethrow;
    }
  }
}
