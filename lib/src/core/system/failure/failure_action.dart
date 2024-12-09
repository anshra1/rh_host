// Dart imports:
import 'dart:ui';

class FailureAction {
  const FailureAction({
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
