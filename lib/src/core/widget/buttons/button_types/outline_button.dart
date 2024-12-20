part of '../import.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    required this.text,
    super.key,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.icon,
    this.tooltip,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isDisabled;
  final Widget? icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text: text,
      onPressed: onPressed,
      size: size,
      variant: ButtonVariant.outline,
      isDisabled: isDisabled,
      icon: icon,
      tooltip: tooltip,
    );
  }
}
