import 'package:flutter/material.dart';
import 'package:rh_host/src/core/constants/string.dart';
import 'package:rh_host/src/core/enum/button_enum.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
import 'package:rh_host/src/core/widget/buttons/import.dart';
import 'package:rh_host/src/core/widget/grid/custom_grid.dart';
import 'package:rh_host/src/features/passcode/presentation/pages/passcode_page/view/passcode_keypad.dart';

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
      return PasscodeKeyButton(
        label: '0',
        onTap: onDigitTap,
      );
    }

    // Delete button for index 11
    if (index == 11) {
      return PasscodeKeyButton(
        label: '⌫',
        onTap: (_) => onDelete.call(),
      );
    }

    // Number buttons 1-9
    return PasscodeKeyButton(
      label: '${index + 1}',
      onTap: onDigitTap,
    );
  }
}
