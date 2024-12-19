// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/system/failure/failure_action.dart';

class FailureConfig {
  const FailureConfig({
    this.defaultDuration = const Duration(seconds: 3),
    this.defaultSnackBarBehavior = SnackBarBehavior.floating,
    this.defaultDialogBarrierDismissible = true,
    this.shouldVibrate = true,
    this.maxVisibleSnackBars = 1,
    Map<ErrorCode, FailureAction>? actionMap,
  }) : actionMap = actionMap ?? const {};

  final Duration defaultDuration;
  final SnackBarBehavior defaultSnackBarBehavior;
  final bool defaultDialogBarrierDismissible;
  final bool shouldVibrate;
  final int maxVisibleSnackBars;
  final Map<ErrorCode, FailureAction> actionMap;
}
