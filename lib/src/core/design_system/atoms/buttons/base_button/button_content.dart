part of '../import.dart';

class ButtonContent extends StatelessWidget {
  const ButtonContent({
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.isLoading,
    this.icon,
    this.suffix,
    super.key,
  });

  final String text;
  final Color textColor;
  final double fontSize;
  final bool isLoading;
  final Widget? icon;
  final Widget? suffix;

  /// Content widget for the button, handling the layout of text, icons, and loading state

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: fontSize,
        width: fontSize,
        child: CircularProgressIndicator(
          color: textColor,
          strokeWidth: 2,
        ),
      );
    }

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
          style: TextStyle(fontSize: fontSize),
        ),
        if (suffix != null) ...[
          SizedBox(width: Spacing.xs),
          suffix!,
        ],
      ],
    );
  }
}
