import 'package:flutter/material.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/domain/status_action.dart';

class StatusFactory {
  static StatusScreenModel success({
    required String title,
    required String message,
    required String buttonText,
    required String nextRoute,
    Map<String, dynamic>? nextRouteParams,
    Duration? autoNavigateAfter,
    bool showCloseButton = true,
    List<StatusAction>? additionalActions,
    Widget? customContent,
    Duration timeout = const Duration(seconds: 3),
  }) {
    return StatusScreenModel(
      type: StatusType.success,
      title: title,
      message: message,
      primaryButtonText: buttonText,
      nextRoute: nextRoute,
      nextRouteParams: nextRouteParams,
      autoNavigateAfter: timeout,
      showCloseButton: showCloseButton,
      additionalActions: additionalActions,
      customContent: customContent,
    );
  }

  static StatusScreenModel error({
    required String title,
    required String message,
    required String buttonText,
    required String nextRoute,
    String? secondaryButtonText,
    bool showCloseButton = true,
    List<StatusAction>? additionalActions,
    Widget? customContent,
  }) {
    return StatusScreenModel(
      type: StatusType.error,
      title: title,
      message: message,
      primaryButtonText: buttonText,
      nextRoute: nextRoute,
      secondaryButtonText: secondaryButtonText,
      showCloseButton: showCloseButton,
      additionalActions: additionalActions,
      customContent: customContent,
    );
  }
}
