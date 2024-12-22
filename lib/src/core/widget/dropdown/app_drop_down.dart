import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.error,
    this.disabled = false,
    super.key,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? error;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppFonts.labelMedium,
          ),
          const SizedBox(height: Spacing.xxs4),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: disabled ? null : onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacing.md16,
              vertical: Spacing.sm12,
            ),
          ),
          style: AppFonts.bodyMedium.copyWith(
            color: disabled ? LightColorsToken.textDisabled : null,
          ),
        ),
      ],
    );
  }
}
