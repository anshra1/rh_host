// Dart imports:
import 'dart:async';
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/system/alert_system/alert.dart';
import 'package:rh_host/src/core/system/alert_system/alert_action.dart';
import 'package:rh_host/src/core/system/alert_system/alert_config.dart';

// Then the AlertManager implementation:

class AlertManager {
  factory AlertManager() => instance;
  AlertManager._internal();
  static final AlertManager instance = AlertManager._internal();

  late final AlertConfig _config;
  final Queue<_AlertItem> _alertQueue = Queue<_AlertItem>();
  Timer? _queueTimer;
  bool _isProcessing = false;

  void initialize({AlertConfig? config}) {
    _config = config ?? const AlertConfig();
  }

  Future<void> show(BuildContext context, Alert alert) async {
    if (!context.mounted) return;

    try {
      _alertQueue.add(_AlertItem(context: context, alert: alert));
      if (!_isProcessing) {
        await _processQueue();
      }
    } catch (e, stackTrace) {
      debugPrint('Error showing alert: $e\n$stackTrace');
    }
  }

  Future<void> _processQueue() async {
    if (_alertQueue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    try {
      while (_alertQueue.isNotEmpty) {
        final item = _alertQueue.removeFirst();
        if (item.context.mounted) {
          await _showAlert(item.context, item.alert);
          // Wait for duration before showing next alert
          await Future<void>.delayed(item.alert.duration);
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  Color _getAlertColor(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Colors.red;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.success:
        return Colors.green;
      case AlertType.info:
        return Colors.blue;
    }
  }

  IconData _getAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Icons.error_outline;
      case AlertType.warning:
        return Icons.warning_amber_rounded;
      case AlertType.success:
        return Icons.check_circle_outline;
      case AlertType.info:
        return Icons.info_outline;
    }
  }

  Future<void> _showAlert(BuildContext context, Alert alert) async {
    if (!context.mounted) return;

    switch (alert.type) {
      case AlertType.error:
        await _showAlertDialog(context, alert);
      case AlertType.warning:
        _showAlertSnackBar(context, alert);
      case AlertType.success:
        await _showAlertDialog(context, alert);
      case AlertType.info:
        _showAlertSnackBar(context, alert);
    }
  }

  Future<void> _showAlertDialog(BuildContext context, Alert alert) {
    return showDialog<void>(
      context: context,
      barrierDismissible: alert.dismissible,
      builder: (BuildContext context) => AlertDialog(
        icon: Icon(
          _getAlertIcon(alert.type),
          color: _getAlertColor(alert.type),
          size: 28,
        ),
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

  void _showAlertSnackBar(BuildContext context, Alert alert) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                _getAlertIcon(alert.type),
                color: theme.colorScheme.onError,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (alert.title != null)
                      Text(
                        alert.title!,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onError,
                        ),
                      ),
                    Text(
                      alert.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onError,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: _getAlertColor(alert.type),
          behavior: _config.defaultSnackBarBehavior,
          duration: alert.duration,
          action: alert.action != null
              ? SnackBarAction(
                  label: alert.action!.label,
                  onPressed: alert.action!.onPressed,
                  textColor: alert.action!.textColor ?? theme.colorScheme.onError,
                )
              : null,
        ),
      );
  }

  // Convenience methods
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
        duration: duration ?? _config.defaultDuration,
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
        duration: duration ?? _config.defaultDuration,
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
        duration: duration ?? _config.defaultDuration,
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
        duration: duration ?? _config.defaultDuration,
      ),
    );
  }

  void clearAll(BuildContext context) {
    _alertQueue.clear();
    _queueTimer?.cancel();
    _queueTimer = null;
    _isProcessing = false;
    if (context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }
}

class _AlertItem {
  _AlertItem({
    required this.context,
    required this.alert,
  });
  final BuildContext context;
  final Alert alert;
}
