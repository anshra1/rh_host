import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/asset/app_icons.dart';

class AppIconViewer extends StatelessWidget {
  const AppIconViewer({
    required this.icon,
    this.size = 24,
    this.showBackground = true,
    this.backgroundScale = 2.0,
    this.onTap,
    super.key,
  });

  final EAppIcons icon;
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
