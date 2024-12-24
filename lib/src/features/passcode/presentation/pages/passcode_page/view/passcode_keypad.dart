import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/widget/buttons/import.dart';

class PasscodeKeyButton extends StatelessWidget {
  const PasscodeKeyButton({
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.size = const Size(70, 70),
    this.isDisabled = false,
    this.hapticFeedback = true,
    super.key,
  });

  final String label;
  final ValueChanged<String> onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Size size;
  final bool isDisabled;
  final bool hapticFeedback;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.colorPrimary;
    final effectiveTextColor = textColor ?? context.colorPrimaryBackground;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: BaseButton(
        text: label,
        onPressed: isDisabled
            ? null
            : () {
                if (hapticFeedback) HapticFeedback.lightImpact();
                onTap(label);
              },
        isDisabled: isDisabled,
        customBackgroundColor: effectiveBackgroundColor,
        customTextColor: effectiveTextColor,
        textStyle: context.textStyle.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: effectiveTextColor,
        ),
      ),
    );
  }
}
