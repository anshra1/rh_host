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
    this.icon,
    this.suffix,
    this.width,
    this.backgroundColor,
    this.tooltip,
    super.key,
  });

  /// The text displayed on the button
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Size variant of the button
  final ButtonSize size;

  /// Visual style variant of the button
  final ButtonVariant variant;

  /// Whether the button is disabled
  final bool isDisabled;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Optional icon to display before the text
  final Widget? icon;

  /// Optional icon to display after the text
  final Widget? suffix;

  /// Optional custom width for the button
  final double? width;

  /// Optional custom background color
  final Color? backgroundColor;

  /// Optional tooltip text
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final config = ButtonConfig.fromSize(size);

    // Determine colors based on variant
    Color bgColor;
    Color textColor;
    var borderSide = BorderSide.none;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = backgroundColor ?? AppColor.primaryColor;
        textColor = AppColor.textInverse;
      case ButtonVariant.secondary:
        bgColor = backgroundColor ?? AppColor.secondary;
        textColor = AppColor.textInverse;
      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = AppColor.primaryColor;
        borderSide = const BorderSide(color: AppColor.primaryColor);
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = AppColor.primaryColor;
    }

    if (isDisabled) {
      bgColor = bgColor.withOpacity(0.6);
      textColor = textColor.withOpacity(0.6);
    }

    final buttonChild = ButtonContent(
      text: text,
      textColor: textColor,
      fontSize: config.fontSize,
      isLoading: isLoading,
      icon: icon,
      suffix: suffix,
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
          child: MaterialButton(
            onPressed: (isDisabled || isLoading) ? null : onPressed,
            color: bgColor,
            textColor: textColor,
            padding: config.padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(config.borderRadius),
              side: borderSide,
            ),
            child: buttonChild,
          ),
        ),
      ),
    );
  }
}
