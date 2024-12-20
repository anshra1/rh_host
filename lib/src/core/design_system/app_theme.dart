import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          primaryContainer: AppColors.primaryLight,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondaryLight,
          error: AppColors.error,
          onSecondary: AppColors.textInverse,
          onSurface: AppColors.textPrimary,
        ),
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        textTheme: const TextTheme(
          // Display styles
          displayLarge: AppFonts.displayLarge,
          displayMedium: AppFonts.displayMedium,
          displaySmall: AppFonts.displaySmall,

          // Headline styles
          headlineLarge: AppFonts.headlineLarge,
          headlineMedium: AppFonts.headlineMedium,
          headlineSmall: AppFonts.headlineSmall,

          // Title styles
          titleLarge: AppFonts.titleLarge,
          titleMedium: AppFonts.titleMedium,
          titleSmall: AppFonts.titleSmall,

          // Label styles
          labelLarge: AppFonts.labelLarge,
          labelMedium: AppFonts.labelMedium,
          labelSmall: AppFonts.labelSmall,

          // Body styles
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
        ),
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
      side: const BorderSide(color: AppColors.border),
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
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColors.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD),
      borderSide: const BorderSide(color: AppColors.borderError),
    ),
    filled: true,
    fillColor: AppColors.backgroundSecondary,
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
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    // titleTextStyle: AppFonts.titleLarge,
  );
}
