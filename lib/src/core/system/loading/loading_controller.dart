// Dart imports:
import 'dart:async';
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';
import 'package:rh_host/src/core/system/failure/failure_manager.dart';
import 'package:rh_host/src/core/system/loading/loading_overlay.dart';

class LoadingController {
  LoadingController._();
  static final instance = LoadingController._();

  final _overlayEntries = HashMap<BuildContext, OverlayEntry>();
  final _startTimes = HashMap<BuildContext, DateTime>();
//  final _analyticsService = FirebaseAnalytics.instance;
  final _timeouts = HashMap<BuildContext, Timer>();

  void show(
    BuildContext context, {
    String? message,
    Duration? timeout,
    bool barrierDismissible = false,
    Map<String, dynamic>? metadata,
  }) {
    if (!context.mounted) return;

    // Track start time
    _startTimes[context] = DateTime.now();

    // Create overlay entry
    final overlayEntry = OverlayEntry(
      builder: (context) => LoadingOverlay(
        message: message,
        onDismiss: barrierDismissible ? () => hide(context) : null,
      ),
    );

    // Show overlay
    Overlay.of(context).insert(overlayEntry);
    _overlayEntries[context] = overlayEntry;

    // Setup timeout
    if (timeout != null) {
      _timeouts[context]?.cancel();
      _timeouts[context] = Timer(timeout, () {
        hide(context);
        _handleTimeout(context, message, metadata);
      });
    }

    // Log analytics
    //  _logLoadingStarted(context, message, metadata);
  }

  void hide(BuildContext context) {
    if (!context.mounted) return;

    // Remove overlay
    final entry = _overlayEntries.remove(context);
    entry?.remove();

    // Cancel timeout
    _timeouts[context]?.cancel();
    _timeouts.remove(context);

    // Log analytics
    final startTime = _startTimes.remove(context);
    if (startTime != null) {
      // _logLoadingEnded(context, startTime);
    }
  }

  void _handleTimeout(
    BuildContext context,
    String? message,
    Map<String, dynamic>? metadata,
  ) {
    if (!context.mounted) return;

    final failure = TimeoutFailure(
      message: 'Operation timed out: $message',
      code: ErrorCode.timeOut,
      category: ErrorCategory.network,
      severity: ErrorSeverity.medium,
    );

    FailureManager.instance.show(context, failure);
  }

  // Future<void> _logLoadingStarted(
  //   BuildContext context,
  //   String? message,
  //   Map<String, dynamic>? metadata,
  // ) async {
  //   await _analyticsService.logEvent(
  //     name: 'loading_started',
  //     parameters: {
  //       'screen': context.router.currentPath,
  //       'message': message,
  //       ...?metadata,
  //     },
  //   );
  // }

  // Future<void> _logLoadingEnded(
  //   BuildContext context,
  //   DateTime startTime,
  // ) async {
  //   final duration = DateTime.now().difference(startTime);

  //   await _analyticsService.logEvent(
  //     name: 'loading_ended',
  //     parameters: {
  //       'screen': context.router.currentPath,
  //       'duration_ms': duration.inMilliseconds,
  //     },
  //   );
  // }
}
