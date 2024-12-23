import 'package:flutter/widgets.dart';

class StatusIconTheme {
  const StatusIconTheme({
    required this.icon,
    required this.color,
    this.animationAsset,
  });

  final IconData icon;
  final Color color;
  final String? animationAsset;
}
