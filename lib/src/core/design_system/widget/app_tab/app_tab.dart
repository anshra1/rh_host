import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/design_system/widget/app_tab/app.dart';

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
      height: AppSize.tabBar,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: AppSize.borderThin,
          ),
        ),
      ),
      child: TabBar(
        tabs: tabs,
        isScrollable: isScrollable,
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppFonts.labelMedium,
        unselectedLabelStyle: AppFonts.labelMedium,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: AppSize.borderMedium,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
