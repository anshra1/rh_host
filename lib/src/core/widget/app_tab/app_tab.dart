import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/widget/app_tab/app.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    this.isScrollable = false,
    super.key,
  });

  final List<AppTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.tabBar48,
      decoration: const BoxDecoration(
        color: LightColorsToken.surface,
        border: Border(
          bottom: BorderSide(
            color: LightColorsToken.border,
          ),
        ),
      ),
      child: TabBar(
        tabs: tabs,
        isScrollable: isScrollable,
        labelColor: LightColorsToken.primaryLight,
        unselectedLabelColor: LightColorsToken.textSecondary,
        labelStyle: AppFonts.labelMedium,
        unselectedLabelStyle: AppFonts.labelMedium,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: LightColorsToken.primaryLight,
            width: AppSize.borderMedium2,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
