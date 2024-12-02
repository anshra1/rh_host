import 'package:flutter/material.dart';

class AlertConfig {
  const AlertConfig({
    this.defaultDuration = const Duration(seconds: 3),
    this.defaultSnackBarBehavior = SnackBarBehavior.floating,
    this.defaultDialogBarrierDismissible = true,
    this.shouldVibrate = true,
    this.maxVisibleSnackBars = 1,
  });

  final Duration defaultDuration;
  final SnackBarBehavior defaultSnackBarBehavior;
  final bool defaultDialogBarrierDismissible;
  final bool shouldVibrate;
  final int maxVisibleSnackBars;
}
