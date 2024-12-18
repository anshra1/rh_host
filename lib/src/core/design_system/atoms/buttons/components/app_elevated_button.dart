part of '../import.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColor.primaryColor,
    this.foregroundColor = AppColor.textInverse,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.textStyle,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
    this.borderRadius = 16,
    this.elevation,
    this.width,
    this.height,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.tooltip,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? tooltip;

  Widget _buildLoadingIndicator() {
    final size = textStyle?.fontSize ?? 24.0;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
      ),
    );
  }

  Widget _buildLabelWithIcons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          SizedBox(width: Spacing.xs),
        ],
        Text(
          label,
          style: textStyle ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
        ),
        if (trailingIcon != null) ...[
          SizedBox(width: Spacing.xs),
          trailingIcon!,
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: !isLoading && onPressed != null,
      label: label,
      child: Tooltip(
        message: tooltip ?? label,
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              disabledBackgroundColor: disabledBackgroundColor,
              disabledForegroundColor: disabledForegroundColor,
              elevation: elevation,
              padding: contentPadding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: AnimatedSwitcher(
              duration: MotionTokens.durationSM,
              child: isLoading ? _buildLoadingIndicator() : _buildLabelWithIcons(context),
            ),
          ),
        ),
      ),
    );
  }
}
