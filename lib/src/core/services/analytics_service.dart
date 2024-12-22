import 'package:flutter/material.dart';

class AnalyticsService {
  void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    // Example implementation for logging events
    debugPrint('Logged event: $eventName with parameters: $parameters');
  }

  void setUserProperty(String propertyName, String value) {
    // Example implementation for setting user properties
    debugPrint('Set user property: $propertyName = $value');
  }

  NavigatorObserver get navigationObserver => _AnalyticsNavigationObserver(this);
}

class _AnalyticsNavigationObserver extends NavigatorObserver {
  _AnalyticsNavigationObserver(this._analyticsService);
  final AnalyticsService _analyticsService;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _analyticsService.logEvent(
      'navigation_push',
      parameters: {'route': route.settings.name},
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _analyticsService.logEvent(
      'navigation_pop',
      parameters: {'route': route.settings.name},
    );
  }
}
