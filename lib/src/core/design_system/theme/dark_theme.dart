// Dark Theme
import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/design_system/theme/custom_color.dart';

class DarkTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: DarkColorsToken.backgroundPrimary,
        brightness: Brightness.dark,
        useMaterial3: true,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        colorScheme: const ColorScheme.dark(
          primary: DarkColorsToken.primaryLight,
          primaryContainer: DarkColorsToken.primaryLight,
          secondary: DarkColorsToken.secondary,
          secondaryContainer: DarkColorsToken.secondaryLight,
          error: DarkColorsToken.error,
          onSecondary: DarkColorsToken.textInverse,
          onSurface: DarkColorsToken.textPrimary,
        ),
        textTheme: TextTheme(
          displayLarge:
              AppFonts.displayLarge.copyWith(color: DarkColorsToken.textPrimary),
          displayMedium:
              AppFonts.displayMedium.copyWith(color: DarkColorsToken.textPrimary),
          displaySmall:
              AppFonts.displaySmall.copyWith(color: DarkColorsToken.textPrimary),
          headlineLarge:
              AppFonts.headlineLarge.copyWith(color: DarkColorsToken.textPrimary),
          headlineMedium:
              AppFonts.headlineMedium.copyWith(color: DarkColorsToken.textPrimary),
          headlineSmall:
              AppFonts.headlineSmall.copyWith(color: DarkColorsToken.textPrimary),
          titleLarge: AppFonts.titleLarge.copyWith(color: DarkColorsToken.textPrimary),
          titleMedium: AppFonts.titleMedium.copyWith(color: DarkColorsToken.textPrimary),
          titleSmall: AppFonts.titleSmall.copyWith(color: DarkColorsToken.textPrimary),
          labelLarge: AppFonts.labelLarge.copyWith(color: DarkColorsToken.textPrimary),
          labelMedium: AppFonts.labelMedium.copyWith(color: DarkColorsToken.textPrimary),
          labelSmall: AppFonts.labelSmall.copyWith(color: DarkColorsToken.textPrimary),
          bodyLarge: AppFonts.bodyLarge.copyWith(color: DarkColorsToken.textPrimary),
          bodyMedium: AppFonts.bodyMedium.copyWith(color: DarkColorsToken.textPrimary),
          bodySmall: AppFonts.bodySmall.copyWith(color: DarkColorsToken.textPrimary),
        ),
        extensions: const [
          CustomColors(
            success: Color(0xFF66BB6A),
            warning: Color(0xFFFFB74D),
            info: Color(0xFF64B5F6),
            border: Color(0xFF373737),
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
      backgroundColor: DarkColorsToken.primaryLight,
      foregroundColor: DarkColorsToken.textInverse,
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
      side: const BorderSide(color: DarkColorsToken.border),
      foregroundColor: DarkColorsToken.textPrimary,
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
      foregroundColor: DarkColorsToken.textPrimary,
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: Spacing.md16,
      vertical: Spacing.sm12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.borderFocus, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusMD8),
      borderSide: const BorderSide(color: DarkColorsToken.borderError),
    ),
    filled: true,
    fillColor: DarkColorsToken.backgroundSecondary,
  );

  static final _cardTheme = CardTheme(
    elevation: ElevationTokens.level1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.radiusLG16),
    ),
    margin: const EdgeInsets.all(Spacing.sm12),
    color: DarkColorsToken.surface,
  );

  static const _appBarTheme = AppBarTheme(
    elevation: ElevationTokens.level0,
    centerTitle: true,
    backgroundColor: DarkColorsToken.surface,
    foregroundColor: DarkColorsToken.textPrimary,
  );
}
