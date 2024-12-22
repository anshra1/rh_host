import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.disabled = false,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: AppSize.buttonSM32,
          width: AppSize.buttonSM32,
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: disabled ? null : onChanged,
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
    );
  }
}
