import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/design_system/theme/custom_color.dart';

class SeedTheme {
  // Seed Colors
  static const _seedColors = (
    primary: Color(0xFF0061A4),
    secondary: Color(0xFF5856D6),
    tertiary: Color(0xFF34C759),
    error: Color(0xFFBA1A1A),
  );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColors.primary,
          secondary: _seedColors.secondary,
          error: _seedColors.error,
        ),
        textTheme: const TextTheme(
          displayLarge: AppFonts.displayLarge,
          displayMedium: AppFonts.displayMedium,
          displaySmall: AppFonts.displaySmall,
          headlineLarge: AppFonts.headlineLarge,
          headlineMedium: AppFonts.headlineMedium,
          headlineSmall: AppFonts.headlineSmall,
          titleLarge: AppFonts.titleLarge,
          titleMedium: AppFonts.titleMedium,
          titleSmall: AppFonts.titleSmall,
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
          labelLarge: AppFonts.labelLarge,
          labelMedium: AppFonts.labelMedium,
          labelSmall: AppFonts.labelSmall,
        ),
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        extensions: const [
          CustomColors(
            success: Color(0xFF43A047),
            warning: Color(0xFFFFA000),
            info: Color(0xFF1976D2),
            border: Color(0xFFE0E0E0),
          ),
        ],
      );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: _seedColors.primary,
          secondary: _seedColors.secondary,
          error: _seedColors.error,
        ),
        textTheme: const TextTheme(
          displayLarge: AppFonts.displayLarge,
          displayMedium: AppFonts.displayMedium,
          displaySmall: AppFonts.displaySmall,
          headlineLarge: AppFonts.headlineLarge,
          headlineMedium: AppFonts.headlineMedium,
          headlineSmall: AppFonts.headlineSmall,
          titleLarge: AppFonts.titleLarge,
          titleMedium: AppFonts.titleMedium,
          titleSmall: AppFonts.titleSmall,
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
          labelLarge: AppFonts.labelLarge,
          labelMedium: AppFonts.labelMedium,
          labelSmall: AppFonts.labelSmall,
        ),
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        extensions: const [
          CustomColors(
            success: Color(0xFF43A047),
            warning: Color(0xFFFFA000),
            info: Color(0xFF1976D2),
            border: Color(0xFF424242),
          ),
        ],
      );

  // Component Themes
  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: ElevationTokens.level1,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md16,
        vertical: Spacing.sm12,
      ),
      minimumSize: Size(AppSize.minButtonWidth64, AppSize.buttonMD40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      ),
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md16,
        vertical: Spacing.sm12,
      ),
      minimumSize: Size(AppSize.minButtonWidth64, AppSize.buttonMD40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      ),
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm12,
        vertical: Spacing.xxs4,
      ),
      minimumSize: Size(AppSize.minButtonWidth64, AppSize.buttonSM32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      ),
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: Spacing.md16,
      vertical: Spacing.sm12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
    ),
    filled: true,
  );

  static final _cardTheme = CardTheme(
    elevation: ElevationTokens.level1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusLG16),
    ),
    margin: const EdgeInsets.all(Spacing.sm12),
  );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
  );
}
