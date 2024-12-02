import 'dart:ui';

class AlertAction {
  const AlertAction({
    required this.label,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
}
