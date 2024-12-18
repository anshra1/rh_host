part of '../import.dart';



class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isDisabled;
  final Widget? icon;
  final String? tooltip;

  const OutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.icon,
    this.tooltip,
  });

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
