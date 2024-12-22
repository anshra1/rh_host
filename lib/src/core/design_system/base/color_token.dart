part of 'import.dart';

/// Design tokens for colors used throughout the app
abstract class LightColorsToken {
  // Primary Brand Colors

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
  static const Color border = neutral600;
  static const Color borderFocus = primaryLight;
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

/// Design tokens for colors used throughout the app
abstract class DarkColorsToken {
  // Primary Brand Colors - Slightly desaturated for dark theme
  static const Color primaryLight = Color(0xFF90CAF9); // Lighter blue
  static const Color primaryDark = Color(0xFF0D47A1); // Darker blue

  // Secondary Brand Colors - Adjusted for dark theme
  static const Color secondary = Color(0xFF4DB6AC); // Lighter teal
  static const Color secondaryLight = Color(0xFF80CBC4); // Even lighter teal
  static const Color secondaryDark = Color(0xFF00796B); // Darker teal

  // Semantic Colors - Slightly muted for dark theme
  static const Color success = Color(0xFF66BB6A); // Lighter green
  static const Color warning = Color(0xFFFFB74D); // Lighter orange
  static const Color error = Color(0xFFE57373); // Lighter red
  static const Color info = Color(0xFF64B5F6); // Lighter blue

  // Neutral Colors - Inverted and adjusted for dark theme
  static const Color neutral0 = Color(0xFF121212); // Dark gray (Material dark background)
  static const Color neutral50 = Color(0xFF1E1E1E); // Slightly lighter
  static const Color neutral100 = Color(0xFF222222);
  static const Color neutral200 = Color(0xFF242424);
  static const Color neutral300 = Color(0xFF272727);
  static const Color neutral400 = Color(0xFF2C2C2C);
  static const Color neutral500 = Color(0xFF2F2F2F);
  static const Color neutral600 = Color(0xFF333333);
  static const Color neutral700 = Color(0xFF373737);
  static const Color neutral800 = Color(0xFF3B3B3B);
  static const Color neutral900 = Color(0xFF424242);
  static const Color neutral1000 = Color(0xFFFFFFFF); // White

  // Text Colors - Inverted for dark theme
  static const Color textPrimary = Color(0xFFE0E0E0); // Light gray
  static const Color textSecondary = Color(0xFF9E9E9E); // Medium gray
  static const Color textDisabled = Color(0xFF616161); // Dark gray
  static const Color textInverse = Color(0xFF121212); // Almost black

  // Background Colors - Dark variants
  static const Color backgroundPrimary = neutral0; // Main dark background
  static const Color backgroundSecondary = neutral50; // Slightly lighter
  static const Color backgroundTertiary = neutral100; // Even lighter

  // Surface Colors - Dark variants
  static const Color surface = neutral0;
  static const Color surfaceHighlight = neutral50;
  static const Color surfaceOverlay = Color(0x80FFFFFF); // White overlay

  // Border Colors - Lighter for visibility
  static const Color border = Color(0xFF373737); // Visible but subtle
  static const Color borderFocus = primaryLight; // Keep primary for focus
  static const Color borderError = error; // Keep error color

  // Shadow Colors - Darker and more intense
  static const Color shadowLight = Color(0x3DFFFFFF); // White shadow
  static const Color shadowDark = Color(0x66000000); // Darker shadow

  // Overlay Colors - Adjusted for dark theme
  static const Color overlay = Color(0x80FFFFFF); // White overlay
  static const Color overlayLight = Color(0x1FFFFFFF); // Light white overlay
  static const Color overlayDark = Color(0xB3000000); // Dark overlay

  // Interactive States - White-based instead of black-based
  static const Color hoverOverlay = Color(0x0AFFFFFF);
  static const Color focusOverlay = Color(0x1FFFFFFF);
  static const Color pressedOverlay = Color(0x14FFFFFF);
  static const Color selectedOverlay = Color(0x0FFFFFFF);
  static const Color draggedOverlay = Color(0x0AFFFFFF);
}
