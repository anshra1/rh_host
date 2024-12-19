// Flutter imports:
import 'package:flutter/widgets.dart';

class StatusTheme {
  const StatusTheme({
    required this.icon,
    required this.color,
    this.animationAsset,
  });

  final IconData icon;
  final Color color;
  final String? animationAsset;
}
