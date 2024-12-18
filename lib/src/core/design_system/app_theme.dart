import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/elevation.dart';
import 'package:rh_host/src/core/design_system/z_import.dart';
import 'package:rh_host/src/core/design_system/size.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primaryColor,
          primaryContainer: AppColor.primaryLight,
          secondary: AppColor.secondary,
          secondaryContainer: AppColor.secondaryLight,
          error: AppColor.error,
          onSecondary: AppColor.textInverse,
          onSurface: AppColor.textPrimary,
        ),

        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        // ... other component themes
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
            // Define dark theme colors
            ),
        // ... other dark theme configurations
      );

  // Component-specific themes
  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ElevationTokens.level1,
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonMD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD),
      ),
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonMD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD),
      ),
      side: const BorderSide(color: AppColor.border),
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xxs,
      ),
      minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonSM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD),
      ),
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      horizontal: Spacing.md,
      vertical: Spacing.sm,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColor.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColor.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColor.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColor.borderError),
    ),
    filled: true,
    fillColor: AppColor.backgroundSecondary,
  );

  static final _cardTheme = CardTheme(
    elevation: ElevationTokens.level1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusLG),
    ),
    margin: EdgeInsets.all(Spacing.sm),
  );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
    backgroundColor: AppColor.surface,
    foregroundColor: AppColor.textPrimary,
    // titleTextStyle: TypographyTokens.titleLarge,
  );
}
