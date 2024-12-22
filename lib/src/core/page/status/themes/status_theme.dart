import 'package:flutter/material.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/domain/status_theme.dart';

final Map<StatusType, StatusTheme> statusThemes = {
  StatusType.success: const StatusTheme(
    icon: Icons.check_circle_outline,
    color: Colors.green,
    animationAsset: 'assets/animation/success-animation.json',
  ),
  StatusType.error: const StatusTheme(
    icon: Icons.error_outline,
    color: Colors.red,
    animationAsset: 'assets/animations/error.json',
  ),
  StatusType.warning: const StatusTheme(
    icon: Icons.warning_outlined,
    color: Colors.orange,
    animationAsset: 'assets/animations/warning.json',
  ),
  StatusType.info: const StatusTheme(
    icon: Icons.info_outline,
    color: Colors.blue,
    animationAsset: 'assets/animations/info.json',
  ),
  StatusType.loading: const StatusTheme(
    icon: Icons.hourglass_empty,
    color: Colors.blue,
    animationAsset: 'assets/animations/loading.json',
  ),
};
