import 'package:flutter/material.dart';

abstract class AppDecoration {
  // Basic rounded decoration
  static BoxDecoration rounded({
    Color? color,
    double radius = 8,
    Color? borderColor,
    double borderWidth = 1,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    BoxShape shape = BoxShape.rectangle,
    DecorationImage? image,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(radius) : null,
      border:
          borderColor != null ? Border.all(color: borderColor, width: borderWidth) : null,
      boxShadow: shadows,
      gradient: gradient,
      shape: shape,
      image: image,
    );
  }

  // Circle decoration
  static BoxDecoration circle({
    Color? color,
    Color? borderColor,
    double borderWidth = 1,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    DecorationImage? image,
  }) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border:
          borderColor != null ? Border.all(color: borderColor, width: borderWidth) : null,
      boxShadow: shadows,
      gradient: gradient,
      image: image,
    );
  }

  // Card decoration
  static BoxDecoration card({
    Color? color,
    double radius = 12,
    Color? borderColor,
    double elevation = 1,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: borderColor != null ? Border.all(color: borderColor) : null,
      boxShadow: [
        BoxShadow(
          color: (shadowColor ?? Colors.black).withAlpha((0.1 * 255).toInt()),
          blurRadius: elevation * 3,
          offset: Offset(0, elevation),
        ),
      ],
    );
  }

  // Container with border
  static BoxDecoration bordered({
    Color? color,
    Color borderColor = const Color(0xFFE0E0E0),
    double borderWidth = 1,
    double radius = 8,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }

  // Gradient decorations
  static BoxDecoration linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
    double radius = 0,
    TileMode tileMode = TileMode.clamp,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
      borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
    );
  }

  static BoxDecoration radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    double borderRadius = 0,
    TileMode tileMode = TileMode.clamp,
  }) {
    return BoxDecoration(
      gradient: RadialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        tileMode: tileMode,
      ),
      borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
    );
  }

  // Common UI element decorations
  static BoxDecoration get button => rounded();

  static BoxDecoration get chip => rounded(
        radius: 16,
      );

  static BoxDecoration get dialogBox => card(
        radius: 16,
        elevation: 2,
      );

  static BoxDecoration get bottomSheet => BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      );

  // Image decorations
  static BoxDecoration image({
    required String url,
    double radius = 0,
    BoxFit fit = BoxFit.cover,
    Color? overlayColor,
  }) {
    return BoxDecoration(
      borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
      image: DecorationImage(
        image: NetworkImage(url),
        fit: fit,
        colorFilter: overlayColor != null
            ? ColorFilter.mode(
                overlayColor,
                BlendMode.srcOver,
              )
            : null,
      ),
    );
  }

  // Shimmer loading decoration
  static BoxDecoration shimmer({
    double radius = 8,
    Color baseColor = const Color(0xFFEEEEEE),
    Color highlightColor = const Color(0xFFFAFAFA),
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: LinearGradient(
        colors: [baseColor, highlightColor, baseColor],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }
}
