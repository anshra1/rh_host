import 'package:flutter/material.dart';

class CrashReportingService {
  void logError(dynamic error, StackTrace? stackTrace) {
    // Example implementation for logging errors
    debugPrint('Logged error: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  void logCustomError(String message, {Map<String, dynamic>? details}) {
    debugPrint('Custom error: $message, details: $details');
  }

  NavigatorObserver get navigationObserver => _CrashReportingNavigationObserver(this);
}

class _CrashReportingNavigationObserver extends NavigatorObserver {
  _CrashReportingNavigationObserver(this._crashReportingService);
  final CrashReportingService _crashReportingService;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _crashReportingService.logCustomError(
      'Navigation push',
      details: {'route': route.settings.name},
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _crashReportingService.logCustomError(
      'Navigation pop',
      details: {'route': route.settings.name},
    );
  }
}
