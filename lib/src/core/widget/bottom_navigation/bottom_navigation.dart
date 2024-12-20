import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.showLabels = true,
    super.key,
  });

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: ElevationTokens.shadow1,
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: showLabels,
          showUnselectedLabels: showLabels,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.textSecondary,
          selectedLabelStyle: AppFonts.labelSmall,
          unselectedLabelStyle: AppFonts.labelSmall,
        ),
      ),
    );
  }
}
