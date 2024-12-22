part of '../import.dart';

/// Defines the shape of the button
enum ButtonShape {
  /// Standard rounded rectangle shape
  rounded,

  /// Fully circular shape
  circle,

  /// Stadium shape (pill-shaped)
  stadium
}

/// A highly customizable base button widget that follows the app's design system.
/// Supports both light and dark themes automatically and different shapes.
class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.shape = ButtonShape.rounded,
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
  final ButtonShape shape;
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine colors based on variant and theme
    Color bgColor;
    Color textColor;
    var borderSide = BorderSide.none;
    double? buttonElevation;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = backgroundColor ?? colorScheme.primary;
        textColor = colorScheme.onPrimary;
        buttonElevation = elevation ?? 2;

      case ButtonVariant.secondary:
        bgColor = backgroundColor ?? colorScheme.secondary;
        textColor = colorScheme.onSecondary;
        buttonElevation = elevation ?? 2;

      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = colorScheme.primary;
        borderSide = BorderSide(color: colorScheme.outline);
        buttonElevation = elevation ?? 0;

      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = colorScheme.primary;
        buttonElevation = elevation ?? 0;
    }

    if (isDisabled) {
      bgColor = theme.disabledColor;
      textColor = theme.colorScheme.onSurface.withOpacity(0.38);
      borderSide = borderSide.copyWith(color: theme.disabledColor);
    }

    final defaultTextStyle = theme.textTheme.titleMedium?.copyWith(
      color: textColor,
      fontWeight: FontWeight.w500,
    );

    // Determine button dimensions and shape based on ButtonShape
    var buttonWidth = width;
    final buttonHeight = config.height;
    OutlinedBorder buttonShape;

    switch (shape) {
      case ButtonShape.rounded:
        buttonShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.borderRadius),
          side: borderSide,
        );
      case ButtonShape.circle:
        // For circle shape, width must equal height
        buttonWidth = buttonHeight;
        buttonShape = CircleBorder(side: borderSide);
      case ButtonShape.stadium:
        buttonShape = StadiumBorder(side: borderSide);
    }

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
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
              padding: shape == ButtonShape.circle ? EdgeInsets.zero : config.padding,
              shape: buttonShape,
              disabledBackgroundColor: theme.disabledColor,
              disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
            ),
            child: isLoading
                ? _buildLoadingIndicator(textColor)
                : _buttonChild(textStyle ?? defaultTextStyle),
          ),
        ),
      ),
    );
  }

  Widget _buttonChild(TextStyle? textStyle) {
    if (shape == ButtonShape.circle) {
      // For circle shape, only show icon or first letter of text
      if (icon != null) {
        return IconTheme(
          data: IconThemeData(size: size == ButtonSize.small ? 20 : 24),
          child: icon!,
        );
      }
      return Text(
        text.isNotEmpty ? text[0].toUpperCase() : '',
        style: textStyle,
      );
    }

    // Normal layout for other shapes
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: Spacing.xs8),
        ],
        Text(
          text,
          style: textStyle,
        ),
        if (suffix != null) ...[
          const SizedBox(width: Spacing.xs8),
          suffix!,
        ],
      ],
    );
  }

  Widget _buildLoadingIndicator(Color color) {
    final size = shape == ButtonShape.circle ? 20 : 24;
    return SizedBox(
      width: size.toDouble(),
      height: size.toDouble(),
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
