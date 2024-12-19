part of 'import.dart';

/// Design tokens for colors used throughout the app
abstract class AppColors {
  // Primary Brand Colors
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1565C0);

  // Secondary Brand Colors
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryLight = Color(0xFF4DB6AC);
  static const Color secondaryDark = Color(0xFF00897B);

  // Semantic Colors
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA000);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);

  // Neutral Colors
  static const Color neutral0 = Color(0xFFFFFFFF); // White
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);
  static const Color neutral1000 = Color(0xFF000000); // Black

  // Text Colors
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral600;
  static const Color textDisabled = neutral400;
  static const Color textInverse = neutral0;

  // Background Colors
  static const Color backgroundPrimary = neutral0;
  static const Color backgroundSecondary = neutral50;
  static const Color backgroundTertiary = neutral100;

  // Surface Colors
  static const Color surface = neutral0;
  static const Color surfaceHighlight = neutral50;
  static const Color surfaceOverlay = Color(0x80000000);

  // Border Colors
  static const Color border = neutral300;
  static const Color borderFocus = primaryColor;
  static const Color borderError = error;

  // Shadow Colors
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x3D000000);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x1F000000);
  static const Color overlayDark = Color(0xB3000000);

  // Interactive States
  static const Color hoverOverlay = Color(0x0A000000);
  static const Color focusOverlay = Color(0x1F000000);
  static const Color pressedOverlay = Color(0x14000000);
  static const Color selectedOverlay = Color(0x0F000000);
  static const Color draggedOverlay = Color(0x0A000000);
}
