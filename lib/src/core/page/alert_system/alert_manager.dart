import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/page/alert_system/alert.dart';
import 'package:rh_host/src/core/page/alert_system/alert_action.dart';
import 'package:rh_host/src/core/page/alert_system/alert_config.dart';
import 'package:rh_host/src/core/page/alert_system/alert_icon.dart';
import 'package:rh_host/src/core/page/alert_system/alert_utils.dart';

class AlertManager {
  factory AlertManager() => _instance;
  AlertManager._internal();
  static final AlertManager _instance = AlertManager._internal();

  late AlertConfig _config;
  final _alertQueue = Queue<Alert>();
  Timer? _queueTimer;

  void initialize({AlertConfig? config}) {
    _config = config ?? const AlertConfig();
  }

  void show(BuildContext context, Alert alert) {
    _alertQueue.add(alert);
    _processQueue(context);
  }

  void _processQueue(BuildContext context) {
    if (_queueTimer?.isActive ?? false) return;
    if (_alertQueue.isEmpty) return;

    final alert = _alertQueue.removeFirst();
    _showAlert(context, alert);

    _queueTimer = Timer(alert.duration, () {
      _queueTimer = null;
      _processQueue(context);
    });
  }

  void clearAll(BuildContext context) {
    _alertQueue.clear();
    _queueTimer?.cancel();
    _queueTimer = null;
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void _showAlert(BuildContext context, Alert alert) {
    switch (alert.type) {
      case AlertType.error:
        _showAlertDialog(context, alert);
      case AlertType.warning:
        _showAlertSnackBar(context, alert);
      case AlertType.success:
        _showAlertDialog(context, alert);
      case AlertType.info:
        _showAlertToast(context, alert);
    }
  }

  void _showAlertDialog(BuildContext context, Alert alert) {
    showDialog<void>(
      context: context,
      barrierDismissible: alert.dismissible,
      builder: (context) => AlertDialog(
        icon: AlertIcon(alert: alert),
        title: alert.title != null ? Text(alert.title!) : null,
        content: Text(alert.message),
        actions: [
          if (alert.dismissible)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          if (alert.action != null)
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                alert.action!.onPressed();
              },
              style: FilledButton.styleFrom(
                foregroundColor: alert.action!.textColor,
                backgroundColor: alert.action!.backgroundColor,
              ),
              child: Text(alert.action!.label),
            ),
        ],
      ),
    );
  }

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

 void _showAlertSnackBar(BuildContext context, Alert alert) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              AlertIcon(alert: alert),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (alert.title != null)
                      Text(
                        alert.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    Text(alert.message),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: AlertUtils.getColor(alert),
          behavior: _config.defaultSnackBarBehavior,
          duration: alert.duration,
          action: alert.action != null
              ? SnackBarAction(
                  label: alert.action!.label,
                  onPressed: alert.action!.onPressed,
                  textColor: alert.action!.textColor,
                )
              : null,
        ),
      );
  }

  void _showAlertToast(BuildContext context, Alert alert) {
    // Implement using your preferred toast package
    // For example, using fluttertoast:
    /*
    Fluttertoast.showToast(
      msg: alert.message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AlertUtils.getColor(alert),
      textColor: Colors.white,
    );
    */
  }
}

// void main(BuildContext context) {
//   AlertManager().showSuccess(
//     context,
//     message: 'Profile updated successfully',
//     action: AlertAction(
//       label: 'View',
//       onPressed: navigateToProfile,
//     ),
//   );

// // Info message
//   AlertManager().showInfo(
//     message: 'New version available',
//     title: 'Update',
//     action: AlertAction(
//       label: 'Update Now',
//       onPressed: startUpdate,
//     ),
//   );

// // Warning message
//   AlertManager().showWarning(
//     context,
//     message: 'Your session will expire soon',
//     action: AlertAction(
//       label: 'Extend',
//       onPressed: extendSession,
//     ),
//   );

// // Error message
//   AlertManager().showError(
//     context,
//     message: 'Failed to save changes',
//     action: AlertAction(
//       label: 'Retry',
//       onPressed: saveChanges,
//     ),
//   );
// }
