import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/design_system/base/app_decoration.dart';
import 'package:rh_host/src/core/design_system/base/border_radius.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
import 'package:rh_host/src/core/extension/widget.dart';
import 'package:rh_host/src/core/widget/grid/custom_grid.dart';
import 'package:rh_host/src/core/widget/text/text.dart';

class PasscodeKeypad extends StatelessWidget {
  const PasscodeKeypad({
    required this.onDigitTap,
    required this.onDelete,
    required this.onForgetPin,
    required this.isLoading,
    this.spacing = 10.0,
    this.aspectRatio = 1.5,
    super.key,
  });

  final ValueChanged<String> onDigitTap;
  final VoidCallback onDelete;
  final VoidCallback onForgetPin;
  final bool isLoading;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: spacing),
          child: TextButton(
            onPressed: onForgetPin,
            child: AppText(
              Strings.forgetPin,
              style: context.textStyle.bodyLarge!.bold.colour(
                context.colorIconInteractive,
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: isLoading,
          child: CustomGrid.evenSpacing(
            itemCount: 12,
            spacing: spacing,
            childAspectRatio: aspectRatio,
            itemBuilder: _buildKeypadButton,
          ),
        ),
        SizedBox(height: spacing * 2),
      ],
    );
  }

  Widget? _buildKeypadButton(BuildContext context, int index) {
    // Empty space for index 9  // number start from 0 remember
    if (index == 9) return const SizedBox.shrink();

    // '0' button for index 10
    if (index == 10) {
      return PasscodeKeypadKey(
        label: '0',
        onTap: onDigitTap,
      );
    }

    // Delete button for index 11
    if (index == 11) {
      return PasscodeKeypadKey(
        label: '⌫',
        onTap: (_) => onDelete.call(),
      );
    }

    // Number buttons 1-9
    return PasscodeKeypadKey(
      label: '${index + 1}',
      onTap: onDigitTap,
    );
  }
}

class PasscodeKeypadKey extends StatelessWidget {
  const PasscodeKeypadKey({
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
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.colorScheme.primary;
    final effectiveTextColor = textColor ?? context.primaryColor;
    final color = isDisabled
        ? effectiveBackgroundColor.withAlpha((0.5 * 255).toInt())
        : effectiveBackgroundColor;

    return Semantics(
      button: true,
      label: 'Keypad number $label',
      enabled: !isDisabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled
              ? null
              : () => {
                    if (hapticFeedback) HapticFeedback.lightImpact(),
                    onTap.call(label),
                  },
          borderRadius: AppBorderRadius.circular12,
          child: Ink(
            width: size.width,
            height: size.height,
            decoration: AppDecoration.rounded(color: color, radius: 12),
            child: AppText(
              label,
              color: isDisabled
                  ? effectiveTextColor.withAlpha((0.5 * 255).toInt())
                  : effectiveTextColor,
              style: context.textStyle.headlineMedium!.bold,
            ).center(),
          ),
        ),
      ),
    );
  }
}
