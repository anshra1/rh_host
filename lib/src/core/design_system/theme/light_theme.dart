import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/design_system/theme/custom_color.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: LightColorsToken.backgroundPrimary,
        brightness: Brightness.light,
        useMaterial3: true,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        colorScheme: const ColorScheme.light(
          primary: LightColorsToken.primaryLight,
          primaryContainer: LightColorsToken.primaryLight,
          secondary: LightColorsToken.secondary,
          secondaryContainer: LightColorsToken.secondaryLight,
          error: LightColorsToken.error,
          onSecondary: LightColorsToken.textInverse,
          onSurface: LightColorsToken.textPrimary,
          outline: LightColorsToken.border,
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
          labelLarge: AppFonts.labelLarge,
          labelMedium: AppFonts.labelMedium,
          labelSmall: AppFonts.labelSmall,
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
        ),
        extensions: const [
          CustomColors(
            success: Color(0xFF43A047),
            warning: Color(0xFFFFA000),
            info: Color(0xFF1976D2),
            border: Color(0xFFE0E0E0),
          ),
        ],
      );

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
      backgroundColor: LightColorsToken.primaryLight,
      foregroundColor: LightColorsToken.textInverse,
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
      side: const BorderSide(color: LightColorsToken.border),
      foregroundColor: LightColorsToken.textPrimary,
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
      foregroundColor: LightColorsToken.textPrimary,
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: Spacing.md16,
      vertical: Spacing.sm12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.border ,width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: LightColorsToken.borderError),
    ),
    filled: true,
    fillColor: LightColorsToken.backgroundSecondary,
  );

  static final _cardTheme = CardTheme(
    elevation: ElevationTokens.level1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusLG16),
    ),
    margin: const EdgeInsets.all(Spacing.sm12),
    color: LightColorsToken.surface,
  );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
    backgroundColor: LightColorsToken.surface,
    foregroundColor: LightColorsToken.textPrimary,
  );
}
