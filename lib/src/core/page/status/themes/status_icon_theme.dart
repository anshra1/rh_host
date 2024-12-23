import 'package:flutter/material.dart';
import 'package:rh_host/src/core/page/status/domain/status_theme.dart';

enum StatusType {
  success(
    icon: Icons.check_circle_outline,
    lightColor: Color(0xFF43A047), // Material Green 600
    darkColor: Color(0xFF81C784), // Material Green 300
    animationAsset: 'assets/animation/success-animation.json',
  ),

  error(
    icon: Icons.error_outline,
    lightColor: Color(0xFFE53935), // Material Red 600
    darkColor: Color(0xFFEF5350), // Material Red 300
    animationAsset: 'assets/animations/error.json',
  ),

  warning(
    icon: Icons.warning_outlined,
    lightColor: Color(0xFFFB8C00), // Material Orange 600
    darkColor: Color(0xFFFFB74D), // Material Orange 300
    animationAsset: 'assets/animations/warning.json',
  ),

  info(
    icon: Icons.info_outline,
    lightColor: Color(0xFF1E88E5), // Material Blue 600
    darkColor: Color(0xFF64B5F6), // Material Blue 300
    animationAsset: 'assets/animations/info.json',
  ),

  loading(
    icon: Icons.hourglass_empty,
    lightColor: Color(0xFF1E88E5), // Material Blue 600
    darkColor: Color(0xFF64B5F6), // Material Blue 300
    animationAsset: 'assets/animations/loading.json',
  );

  const StatusType({
    required this.icon,
    required this.lightColor,
    required this.darkColor,
    required this.animationAsset,
  });

  final IconData icon;
  final Color lightColor;
  final Color darkColor;
  final String animationAsset;

  // Helper method to get the appropriate color based on theme brightness
  Color getColor(Brightness brightness) {
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  // Get the StatusIconTheme based on the current brightness
  StatusIconTheme getTheme(Brightness brightness) {
    return StatusIconTheme(
      icon: icon,
      color: getColor(brightness),
      animationAsset: animationAsset,
    );
  }
}

// Usage Example:
