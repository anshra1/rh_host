// ignore_for_file: avoid_redundant_argument_values

part of '../import.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      variant: ButtonVariant.primary,
      isDisabled: isDisabled,
      icon: icon,
      tooltip: tooltip,
    );
  }
}
