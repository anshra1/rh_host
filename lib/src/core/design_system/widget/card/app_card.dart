// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? ElevationTokens.level1,
      margin: margin ?? EdgeInsets.all(Spacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppSize.radiusLG),
      ),
      color: backgroundColor ?? AppColors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSize.radiusLG),
        child: Padding(
          padding: padding ?? EdgeInsets.all(Spacing.md),
          child: child,
        ),
      ),
    );
  }
}
