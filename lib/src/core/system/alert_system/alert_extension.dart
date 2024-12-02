import 'package:flutter/material.dart';
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/system/alert_system/alert.dart';
import 'package:rh_host/src/core/system/alert_system/alert_action.dart';
import 'package:rh_host/src/core/system/alert_system/alert_manager.dart';

extension AlertManagerExtensions on AlertManager {
  void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    AlertAction? action,
    Duration? duration,
  }) {
    show(
      context,
      Alert(
        message: message,
        title: title,
        type: AlertType.success,
        action: action,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  void showError(
    BuildContext context, {
    required String message,
    String? title,
    AlertAction? action,
    Duration? duration,
  }) {
    show(
      context,
      Alert(
        message: message,
        title: title,
        type: AlertType.error,
        action: action,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    AlertAction? action,
    Duration? duration,
  }) {
    show(
      context,
      Alert(
        message: message,
        title: title,
        type: AlertType.warning,
        action: action,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    AlertAction? action,
    Duration? duration,
  }) {
    show(
      context,
      Alert(
        message: message,
        title: title,
        type: AlertType.info,
        action: action,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
}
