import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    required this.onChanged,
    this.label,
    this.error,
    this.disabled = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? error;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: AppSize.buttonSM32,
              width: AppSize.buttonSM32,
              child: Checkbox(
                value: value,
                onChanged: disabled ? null : (value) => onChanged?.call(value!),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            if (label != null) ...[
              const SizedBox(width: Spacing.sm12),
              Expanded(
                child: Text(
                  label!,
                  style: AppFonts.bodyMedium.copyWith(
                    color: disabled ? LightColorsToken.textDisabled : null,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (error != null) ...[
          const SizedBox(height: Spacing.xxs4),
          Text(
            error!,
            style: AppFonts.labelSmall.copyWith(
              color: LightColorsToken.error,
            ),
          ),
        ],
      ],
    );
  }
}
