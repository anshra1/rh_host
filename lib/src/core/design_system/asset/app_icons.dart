// app_icons.dart
import 'package:flutter/material.dart';

enum AppIcons {
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

  const AppIcons({
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

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    required this.icon,
    this.size = 24,
    this.showBackground = true,
    this.backgroundScale = 2.0,
    this.onTap,
    super.key,
  });

  final AppIcons icon;
  final double size;
  final bool showBackground;
  final double backgroundScale;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final iconColor = brightness == Brightness.light ? icon.lightColor : icon.darkColor;
    final backgroundColor = brightness == Brightness.light
        ? icon.lightBackgroundColor
        : icon.darkBackgroundColor;

    final iconWidget = Icon(
      icon.icon,
      size: size,
      color: iconColor,
    );

    if (!showBackground) {
      return onTap != null
          ? IconButton(
              icon: iconWidget,
              onPressed: onTap,
            )
          : iconWidget;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size * backgroundScale / 2),
      child: Container(
        width: size * backgroundScale,
        height: size * backgroundScale,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
      ),
    );
  }
}
