import 'package:flutter/material.dart';

class AppFonts {
  // Static properties for text styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.33,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.27,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Static methods for dialog text styles
  static TextStyle dialogTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600);

  static TextStyle dialogButton(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500);
}


// Display (Large 57, Medium 45, Small 36)

// Splash screens
// Hero sections
// Very large numbers/stats
// Welcome screens headers

// Headline (Large 32, Medium 28, Small 24)

// App bar titles in main screens
// Section headers
// Modal/Dialog headers
// Feature introductions

// Title (Large 22, Medium 16, Small 14)

// Card titles
// List headers
// Settings section headers
// Navigation drawer headers
// Dropdown headers

// Label (Large 14, Medium 12, Small 11)

// Button text
// Tab labels
// Input field labels
// Menu items
// Chip text
// Navigation items
// Form field labels

// Body (Large 16, Medium 14, Small 12)

// Primary content text
// List item text
// Description text
// Dialog content
// Card content
// Form input text
// Menu item descriptions
// Secondary information

// Common Component Examples:

// AppBar


// Title: Headline Small (24)
// Subtitle: Title Medium (16)
// Action buttons: Label Large (14)


// Buttons


// Primary/Secondary: Label Large (14)
// Text buttons: Label Large (14)
// Button with icon: Label Large (14)


// Cards


// Card title: Title Medium (16)
// Card content: Body Medium (14)
// Card actions: Label Large (14)


// Forms


// Input labels: Label Medium (12)
// Input text: Body Large (16)
// Helper text: Body Small (12)
// Error text: Label Small (11)


// Dialogs


// Dialog title: Headline Small (24)
// Dialog content: Body Medium (14)
// Dialog buttons: Label Large (14)


// Bottom Navigation


// Labels: Label Medium (12)


// Lists


// List title: Title Large (22)
// List item text: Body Large (16)
// List item secondary: Body Medium (14)


// Tabs


// Tab labels: Label Large (14)


// Chips


// Chip text: Label Large (14)


// Tooltips


// Tooltip text: Label Small (11)