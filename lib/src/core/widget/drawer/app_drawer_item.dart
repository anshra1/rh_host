import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppDrawerItem extends StatelessWidget {
  const AppDrawerItem({
    required this.title,
    this.icon,
    this.onTap,
    this.selected = false,
    super.key,
  });

  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              color: selected
                  ? LightColorsToken.primaryLight
                  : LightColorsToken.textSecondary,
            )
          : null,
      title: Text(
        title,
        style: AppFonts.bodyMedium.copyWith(
          color: selected ? LightColorsToken.primaryLight : LightColorsToken.textPrimary,
        ),
      ),
      selected: selected,
      selectedTileColor: LightColorsToken.selectedOverlay,
      onTap: onTap,
    );
  }
}
