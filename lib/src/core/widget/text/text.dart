// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';

/// A comprehensive typography system following modern design principles and industry standards.
/// Usage:
/// - AppText.display(): For the largest text like splash screens or big numbers
/// - AppText.headline(): For section headers and important titles
/// - AppText.title(): For content titles and medium emphasis headers
/// - AppText.body(): For regular content text
/// - AppText.label(): For smaller text like captions or auxiliary information
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    required this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.color,
    this.decoration,
    this.softWrap,
    this.height,
    super.key,
  });
  factory AppText.labelLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.labelLarge,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.displayLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.displayLarge,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.displayMedium(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.displayMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.displaySmall(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.displaySmall,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.headlineLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.headlineLarge,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.headlineMedium(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.headlineMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.headlineSmall(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.headlineSmall,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.titleLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.titleLarge,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.titleMedium(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.titleMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.titleSmall(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.titleSmall,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.bodyLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.bodyLarge,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.bodyMedium(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.bodyMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.bodySmall(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.bodySmall,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.labelMedium(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.labelMedium,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  factory AppText.labelSmall(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      style: AppFonts.labelSmall,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;

    var finalStyle = style.copyWith(
      color: color,
      decoration: decoration,
      height: height,
    );

    // Merge with default style while preserving specified attributes
    finalStyle = defaultStyle.merge(finalStyle);

    return Text(
      text,
      style: finalStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }

  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final TextDecoration? decoration;
  final bool? softWrap;
  final double? height;
}

void main() {
  const AppText(
    '',
    style: TextStyle(),
  );
  AppText.displayLarge('text');
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