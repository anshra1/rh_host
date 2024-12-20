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
              height: AppSize.buttonSM,
              width: AppSize.buttonSM,
              child: Checkbox(
                value: value,
                onChanged: disabled ? null : (value) => onChanged?.call(value!),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
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
        ),
        if (error != null) ...[
          SizedBox(height: Spacing.xxs),
          Text(
            error!,
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
