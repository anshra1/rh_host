// ignore_for_file: unused_element

import 'package:flutter/material.dart';

/// A comprehensive typography system following modern design principles and industry standards.
/// Usage:
/// - AppText.display(): For the largest text like splash screens or big numbers
/// - AppText.headline(): For section headers and important titles
/// - AppText.title(): For content titles and medium emphasis headers
/// - AppText.body(): For regular content text
/// - AppText.label(): For smaller text like captions or auxiliary information
class AppText extends StatelessWidget {
  factory AppText.labelLarge(
    String text, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText._(
      text,
      style: labelLargeStyle,
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
    return AppText._(
      text,
      style: displayLargeStyle,
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
    return AppText._(
      text,
      style: displayMediumStyle,
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
    return AppText._(
      text,
      style: displaySmallStyle,
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
    return AppText._(
      text,
      style: headlineLargeStyle,
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
    return AppText._(
      text,
      style: headlineMediumStyle,
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
    return AppText._(
      text,
      style: headlineSmallStyle,
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
    return AppText._(
      text,
      style: titleLargeStyle,
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
    return AppText._(
      text,
      style: titleMediumStyle,
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
    return AppText._(
      text,
      style: titleSmallStyle,
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
    return AppText._(
      text,
      style: bodyLargeStyle,
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
    return AppText._(
      text,
      style: bodyMediumStyle,
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
    return AppText._(
      text,
      style: bodySmallStyle,
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
    return AppText._(
      text,
      style: labelMediumStyle,
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
    return AppText._(
      text,
      style: labelSmallStyle,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  const AppText._(
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

  // Display styles - For hero text and large numbers
  static TextStyle displayLargeStyle = const TextStyle(
    fontSize: 57,
    height: 1.12,
    letterSpacing: -0.25,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displayMediumStyle = const TextStyle(
    fontSize: 45,
    height: 1.16,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmallStyle = const TextStyle(
    fontSize: 36,
    height: 1.22,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  // Headline styles - For section headers and key content
  static TextStyle headlineLargeStyle = const TextStyle(
    fontSize: 32,
    height: 1.25,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineMediumStyle = const TextStyle(
    fontSize: 28,
    height: 1.29,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineSmallStyle = const TextStyle(
    fontSize: 24,
    height: 1.33,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  );

  // Title styles - For card titles and medium emphasis headers
  static TextStyle titleLargeStyle = const TextStyle(
    fontSize: 22,
    height: 1.27,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleMediumStyle = const TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleSmallStyle = const TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  // Body styles - For main content and readable text
  static TextStyle bodyLargeStyle = const TextStyle(
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMediumStyle = const TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmallStyle = const TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  );

  // Label styles - For auxiliary information and UI elements
  static TextStyle labelLargeStyle = const TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelMediumStyle = const TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  );

  static TextStyle labelSmallStyle = const TextStyle(
    fontSize: 11,
    height: 1.45,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  );

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
