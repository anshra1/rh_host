import 'package:flutter/material.dart';
// Package imports:
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/presentation/screens/status_screen_simple.dart';

class StatusNavigation {
  const StatusNavigation();

  static Future<void> moveToSucessScreen({
    required BuildContext context,
    required StatusScreenModel status,
    bool replace = true,
    String statusTypeScreen = StatusScreenSimple.routeName,
  }) async {
    if (replace) {
      context.pushReplacementNamed(statusTypeScreen, extra: status);
    } else {
      await context.pushNamed(statusTypeScreen, extra: status);
    }
  }

  static Future<void> handleNavigation({
    required BuildContext context,
    required StatusScreenModel status,
    String statusTypeScreen = StatusScreenSimple.routeName,
  }) async {
    if (status.nextRouteParams != null) {
      await context.pushNamed(
        status.nextRoute,
        extra: status.nextRouteParams,
      );
    } else {
      context.go(status.nextRoute);
    }
  }
}
