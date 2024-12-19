part of '../import.dart';

class ButtonConfig {
  const ButtonConfig({
    required this.height,
    required this.padding,
    required this.borderRadius,
    required this.fontSize,
  });

  /// Creates a ButtonConfig instance based on the specified ButtonSize.
  factory ButtonConfig.fromSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return ButtonConfig(
          height: AppSize.buttonSM,
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          borderRadius: AppSize.radiusSM,
          fontSize: 14,
        );
      case ButtonSize.medium:
        return ButtonConfig(
          height: AppSize.buttonMD,
          padding: EdgeInsets.symmetric(horizontal: Spacing.md),
          borderRadius: AppSize.radiusMD,
          fontSize: 16,
        );
      case ButtonSize.large:
        return ButtonConfig(
          height: AppSize.buttonLG,
          padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
          borderRadius: AppSize.radiusLG,
          fontSize: 18,
        );
    }
  }

  final double height;
  final EdgeInsets padding;
  final double borderRadius;
  final double fontSize;
}
