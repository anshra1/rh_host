// Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/errror_system/error_details.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';

class ErrorHandler {
  ErrorHandler({
    required FirebaseAnalytics analytics,
    required FirebaseCrashlytics crashlytics,
  })  : _analytics = analytics,
        _crashlytics = crashlytics;

  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;

  // Caching for frequent errors
  static final Map<String, ErrorDetails> _errorDetailsCache = {};

  // Queue for batching analytics
  final List<ErrorDetails> _analyticsQueue = [];
  static const int _analyticsBatchSize = 10;

  Future<void> handleError(
    dynamic error, {
    StackTrace? stackTrace,
    String? methodName,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // Process and enrich error details
      final errorDetails = _processError(
        error,
        methodName,
        additionalData,
      );

      // Log to analytics and crashlytics
      await Future.wait([
        _logError(errorDetails, stackTrace),
        _queueAnalytics(errorDetails),
        if (_shouldReportToCrashlytics(errorDetails))
          _reportToCrashlytics(errorDetails, stackTrace),
      ]);
    } catch (e, s) {
      DebugLogger.instance.error('Error in error handler', e, s);
    }
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
      name: 'server_errors',
      parameters: {'errors': batchedDetails},
    );
    _analyticsQueue.clear();
  }

  ErrorDetails _processError(
    dynamic error,
    String? methodName,
    Map<String, dynamic>? additionalData,
  ) {
    final cacheKey = '${error.runtimeType}:${methodName ?? ""}';

    if (_errorDetailsCache.containsKey(cacheKey)) {
      return _errorDetailsCache[cacheKey]!.copyWith(
        additionalData: additionalData,
        timestamp: DateTime.now(),
      );
    }

    final details = error is AppException
        ? ErrorDetails.fromException(error, methodName, additionalData)
        : ErrorDetails.fromDynamic(error, methodName, additionalData);

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
    DebugLogger.instance.error(details.message, details.originalError, stackTrace);
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
        details.severity != ErrorSeverity.fatal) {
      return false;
    }
    return true;
  }
}
