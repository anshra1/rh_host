part of '../import.dart';

/// A highly customizable base button widget that follows the app's design system.
///
/// This button component supports different sizes, variants, loading states,
/// and can include icons. It maintains consistency with the app's design tokens.
class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.isDisabled = false,
    this.isLoading = false,
    this.textStyle,
    this.icon,
    this.suffix,
    this.width,
    this.backgroundColor,
    this.tooltip,
    this.elevation,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isDisabled;
  final bool isLoading;
  final Widget? icon;
  final Widget? suffix;
  final double? width;
  final Color? backgroundColor;
  final String? tooltip;
  final double? elevation;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final config = ButtonConfig.fromSize(size);

    // Determine colors based on variant
    Color bgColor;
    Color textColor;
    var borderSide = BorderSide.none;
    double? buttonElevation;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = backgroundColor ?? AppColors.primaryColor;
        textColor = AppColors.textInverse;
        buttonElevation = elevation ?? 2;

      case ButtonVariant.secondary:
        bgColor = backgroundColor ?? AppColors.secondary;
        textColor = AppColors.textInverse;
        buttonElevation = elevation ?? 2;

      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = AppColors.primaryColor;
        borderSide = const BorderSide(color: AppColors.primaryColor);
        buttonElevation = elevation ?? 0;

      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = AppColors.primaryColor;
        buttonElevation = elevation ?? 0;
    }

    if (isDisabled) {
      bgColor = bgColor.withAlpha((0.6 * 255).toInt());
      textColor = textColor.withAlpha((0.6 * 255).toInt());
    }

    final defaultTextStyle = AppFonts.titleMedium.copyWith(
      color: textColor,
      fontWeight: FontWeight.w500,
    );

    return SizedBox(
      height: config.height,
      width: width,
      child: Semantics(
        button: true,
        enabled: !isDisabled && !isLoading,
        label: text,
        child: Tooltip(
          message: tooltip ?? text,
          child: ElevatedButton(
            onPressed: (isDisabled || isLoading) ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: textColor,
              elevation: buttonElevation,
              padding: config.padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(config.borderRadius),
                side: borderSide,
              ),
              disabledBackgroundColor: bgColor,
              disabledForegroundColor: textColor,
            ),
            child: isLoading
                ? _buildLoadingIndicator()
                : _buttonChild(textStyle ?? defaultTextStyle),
          ),
        ),
      ),
    );
  }

  Widget _buttonChild(TextStyle textStyle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          SizedBox(width: Spacing.xs),
        ],
        Text(
          text,
          style: textStyle,
        ),
        if (suffix != null) ...[
          SizedBox(width: Spacing.xs),
          suffix!,
        ],
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
