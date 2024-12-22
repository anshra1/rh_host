import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.disabled = false,
    this.avatar,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool selected;
  final bool disabled;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: disabled ? null : (value) => onTap?.call(),
      selected: selected,
      avatar: avatar,
      onDeleted: disabled ? null : onDeleted,
      labelStyle: AppFonts.labelMedium.copyWith(
        color: disabled
            ? LightColorsToken.textDisabled
            : selected
                ? LightColorsToken.textInverse
                : LightColorsToken.textPrimary,
      ),
      backgroundColor: LightColorsToken.surfaceHighlight,
      selectedColor: LightColorsToken.primaryLight,
      disabledColor: LightColorsToken.neutral200,
    );
  }
}
