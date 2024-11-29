import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/errror/failure.dart';
import 'package:rh_host/src/core/page/failure/failure_config.dart';
import 'package:rh_host/src/core/page/failure/failure_dialog.dart';
import 'package:rh_host/src/core/page/failure/failure_snack_bar.dart';

class FailureManager {
  factory FailureManager() => _instance;
  FailureManager._internal();
  static final FailureManager _instance = FailureManager._internal();

  late FailureConfig _config;
  final _overlayQueue = Queue<Failure>();
  Timer? _queueTimer;

// not help in Showing UI
  void initialize({FailureConfig? config}) {
    _config = config ?? const FailureConfig();
  }

  void show(BuildContext context, Failure failure) {
    _overlayQueue.addLast(failure);
    _processQueue(context);
  }

  void _processQueue(BuildContext context) {
    if (_queueTimer?.isActive ?? false) return;

    if (_overlayQueue.isEmpty) return;

    final failure = _overlayQueue.removeFirst();

    _showFailure(context, failure);

    _queueTimer = Timer(_config.defaultDuration, () {
      _queueTimer = null;
      _processQueue(context);
    });
  }

  void clearAll(BuildContext context) {
    _overlayQueue.clear();
    _queueTimer?.cancel();
    _queueTimer = null;
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void _showFailure(BuildContext context, Failure failure) {
    if (_config.shouldVibrate) {
      HapticFeedback.mediumImpact();
    }

    switch (failure.severity) {
      case ErrorSeverity.high || ErrorSeverity.fatal:
        _showFailureDialog(context, failure);
      case ErrorSeverity.medium:
        _showFailureSnackBar(context, failure);
      case ErrorSeverity.low:
        _showFailureToast(context, failure);
      case ErrorSeverity.unknown:
        _showFailureToast(context, failure);
    }
  }

  void _showFailureDialog(BuildContext context, Failure failure) {
    showDialog<void>(
      context: context,
      barrierDismissible: _config.defaultDialogBarrierDismissible,
      builder: (context) => FailureDialog(
        failure: failure,
        config: _config,
      ),
    );
  }

  void _showFailureSnackBar(BuildContext context, Failure failure) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        FailureSnackBar(
          failure: failure,
          config: _config,
        ),
      );
  }

  void _showFailureToast(BuildContext context, Failure failure) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        FailureSnackBar(
          failure: failure,
          config: _config,
        ),
      );
  }
}
