// import 'package:flutter/material.dart';
// import 'package:rh_host/src/core/design_system/base/app_font.dart';
// import 'package:rh_host/src/core/design_system/base/elevation.dart';
// import 'package:rh_host/src/core/design_system/base/import.dart';
// import 'package:rh_host/src/core/design_system/base/size.dart';

// class AppTheme {
//   static ThemeData get light => ThemeData(
//         scaffoldBackgroundColor: ColorsToken.backgroundPrimary,
//         useMaterial3: true,
//         colorScheme: const ColorScheme.light(
//           primary: ColorsToken.primaryLight,
//           primaryContainer: ColorsToken.primaryLight,
//           secondary: ColorsToken.secondary,
//           secondaryContainer: ColorsToken.secondaryLight,
//           error: ColorsToken.error,
//           onSecondary: ColorsToken.textInverse,
//           onSurface: ColorsToken.textPrimary,
//         ),
//         elevatedButtonTheme: _elevatedButtonTheme,
//         outlinedButtonTheme: _outlinedButtonTheme,
//         textButtonTheme: _textButtonTheme,
//         inputDecorationTheme: _inputDecorationTheme,
//         cardTheme: _cardTheme,
//         appBarTheme: _appBarTheme,
//         textTheme: const TextTheme(
//           // Display styles
//           displayLarge: AppFonts.displayLarge,
//           displayMedium: AppFonts.displayMedium,
//           displaySmall: AppFonts.displaySmall,

//           // Headline styles
//           headlineLarge: AppFonts.headlineLarge,
//           headlineMedium: AppFonts.headlineMedium,
//           headlineSmall: AppFonts.headlineSmall,

//           // Title styles
//           titleLarge: AppFonts.titleLarge,
//           titleMedium: AppFonts.titleMedium,
//           titleSmall: AppFonts.titleSmall,

//           // Label styles
//           labelLarge: AppFonts.labelLarge,
//           labelMedium: AppFonts.labelMedium,
//           labelSmall: AppFonts.labelSmall,

//           // Body styles
//           bodyLarge: AppFonts.bodyLarge,
//           bodyMedium: AppFonts.bodyMedium,
//           bodySmall: AppFonts.bodySmall,
//         ),
//       );

//   static ThemeData get dark => ThemeData(
//         useMaterial3: true,
//         colorScheme: const ColorScheme.dark(
//             // Define dark theme colors
//             ),
//         // ... other dark theme configurations
//       );

//   // Component-specific themes
//   static final _elevatedButtonTheme = ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       elevation: ElevationTokens.level1,
//       padding: const EdgeInsets.symmetric(
//         horizontal: Spacing.md16,
//         vertical: Spacing.sm12,
//       ),
//       minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonMD),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       ),
//     ),
//   );

//   static final _outlinedButtonTheme = OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//       padding: const EdgeInsets.symmetric(
//         horizontal: Spacing.md16,
//         vertical: Spacing.sm12,
//       ),
//       minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonMD),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       ),
//       side: const BorderSide(color: ColorsToken.border),
//     ),
//   );

//   static final _textButtonTheme = TextButtonThemeData(
//     style: TextButton.styleFrom(
//       padding: const EdgeInsets.symmetric(
//         horizontal: Spacing.sm12,
//         vertical: Spacing.xxs4,
//       ),
//       minimumSize: Size(AppSize.minButtonWidth, AppSize.buttonSM),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       ),
//     ),
//   );

//   static final _inputDecorationTheme = InputDecorationTheme(
//     contentPadding: const EdgeInsets.symmetric(
//       horizontal: Spacing.md16,
//       vertical: Spacing.sm12,
//     ),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       borderSide: const BorderSide(color: ColorsToken.border),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       borderSide: const BorderSide(color: ColorsToken.border),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       borderSide: const BorderSide(color: ColorsToken.borderFocus, width: 2),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSize.radiusMD),
//       borderSide: const BorderSide(color: ColorsToken.borderError),
//     ),
//     filled: true,
//     fillColor: ColorsToken.backgroundSecondary,
//   );

//   static final _cardTheme = CardTheme(
//     elevation: ElevationTokens.level1,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(AppSize.radiusLG16),
//     ),
//     margin: const EdgeInsets.all(Spacing.sm12),
//   );

//   static const _appBarTheme = AppBarTheme(
//     elevation: ElevationTokens.level0,
//     centerTitle: true,
//     backgroundColor: ColorsToken.surface,
//     foregroundColor: ColorsToken.textPrimary,
//     // titleTextStyle: AppFonts.titleLarge,
//   );
// }
