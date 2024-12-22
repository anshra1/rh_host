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
          height: AppSize.buttonSM32,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.sm12),
          borderRadius: AppSize.radiusSM4,
          fontSize: 14,
        );
      case ButtonSize.medium:
        return ButtonConfig(
          height: AppSize.buttonMD40,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md16),
          borderRadius: AppSize.radiusMD8,
          fontSize: 16,
        );
      case ButtonSize.large:
        return ButtonConfig(
          height: AppSize.buttonLG48,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.lg24),
          borderRadius: AppSize.radiusLG16,
          fontSize: 18,
        );
    }
  }

  final double height;
  final EdgeInsets padding;
  final double borderRadius;
  final double fontSize;
}
