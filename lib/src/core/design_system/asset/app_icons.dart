// app_icons.dart
import 'package:flutter/material.dart';

enum EAppIcons {
  success(
    icon: Icons.check_circle_outline,
    lightColor: Color(0xFF43A047),
    darkColor: Color(0xFF81C784),
    lightBackgroundColor: Color(0x1A43A047), // 10% opacity
    darkBackgroundColor: Color(0x1A81C784),
  ),

  info(
    icon: Icons.info_outline,
    lightColor: Color(0xFF43A047),
    darkColor: Color(0xFF81C784),
    lightBackgroundColor: Color(0x1A43A047), // 10% opacity
    darkBackgroundColor: Color(0x1A81C784),
  ),

  error(
    icon: Icons.error_outline,
    lightColor: Color(0xFFE53935),
    darkColor: Color(0xFFEF5350),
    lightBackgroundColor: Color(0x1AE53935),
    darkBackgroundColor: Color(0x1AEF5350),
  ),

  warning(
    icon: Icons.warning_outlined,
    lightColor: Color(0xFFFB8C00),
    darkColor: Color(0xFFFFB74D),
    lightBackgroundColor: Color(0x1AFB8C00),
    darkBackgroundColor: Color(0x1AFFB74D),
  ),

  loading(
    icon: Icons.hourglass_empty,
    lightColor: Color(0xFF1E88E5),
    darkColor: Color(0xFF64B5F6),
    lightBackgroundColor: Color(0x1A1E88E5),
    darkBackgroundColor: Color(0x1A64B5F6),
  );

  const EAppIcons({
    required this.icon,
    required this.lightColor,
    required this.darkColor,
    required this.lightBackgroundColor,
    required this.darkBackgroundColor,
  });

  final IconData icon;
  final Color lightColor;
  final Color darkColor;
  final Color lightBackgroundColor;
  final Color darkBackgroundColor;
}

