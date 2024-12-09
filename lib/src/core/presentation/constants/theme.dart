// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/presentation/constants/colors.dart';
import 'package:rh_host/src/core/presentation/constants/font.dart';

class AppTheme {
  //
  // For Light Mode
  //
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      // foregroundColor: AppColors.darkPrimaryVariantColor,
      backgroundColor: AppColor.backgroundColor,
      //  actionsIconTheme: IconThemeData(color: AppColors.darkPrimaryVariantColor),
      // iconTheme: IconThemeData(color: AppColors.darkPrimaryVariantColor),
    ),
    textTheme: AppFonts.lightTextTheme(),

    //  splashColor: AppColors.lightPrimaryColor.withOpacity(0.1),
    //  highlightColor: AppColors.lightPrimaryColor.withOpacity(0.1),
    // colorScheme: const ColorScheme.light(
    //    primary: AppColors.lightPrimaryColor,
    //   primaryContainer: AppColors.lightPrimaryContainer,
    //   // primaryVariant: AppColors.lightPrimaryVariantColor,
    //   // secondary: AppColors.lightSecondaryColor,
    //   // onPrimary: AppColors.lightOnPrimaryColor,
    // ).copyWith(
    //   surface: AppColors.lightBackgroundColor,
    // ),
    //
    // bottomAppBarColor: Colors.white,
    //
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    // iconTheme: IconThemeData(
    //   color: AppColors.iconColor,
    // ),
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: AppColors.iconColor,
    // ),
    // textTheme: AppFonts.lightTextTheme,
  );
}
