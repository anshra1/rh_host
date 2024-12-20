import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    this.label,
    this.disabled = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: disabled ? null : onChanged,
        ),
        if (label != null) ...[
          SizedBox(width: Spacing.sm),
          Expanded(
            child: Text(
              label!,
              style: AppFonts.bodyMedium.copyWith(
                color: disabled ? AppColors.textDisabled : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
