// lib/src/core/design_system/base/border_radius.dart

import 'package:flutter/material.dart';

abstract class AppBorderRadius {
  // Circular - All corners equal
  static BorderRadius get circular2 => BorderRadius.circular(2);
  static BorderRadius get circular4 => BorderRadius.circular(4);
  static BorderRadius get circular8 => BorderRadius.circular(8);
  static BorderRadius get circular12 => BorderRadius.circular(12);
  static BorderRadius get circular16 => BorderRadius.circular(16);
  static BorderRadius get circular20 => BorderRadius.circular(20);
  static BorderRadius get circular24 => BorderRadius.circular(24);
  static BorderRadius get circular32 => BorderRadius.circular(32);

  // Top corners only
  static BorderRadius get top4 => const BorderRadius.vertical(top: Radius.circular(4));
  static BorderRadius get top8 => const BorderRadius.vertical(top: Radius.circular(8));
  static BorderRadius get top12 => const BorderRadius.vertical(top: Radius.circular(12));
  static BorderRadius get top16 => const BorderRadius.vertical(top: Radius.circular(16));
  static BorderRadius get top24 => const BorderRadius.vertical(top: Radius.circular(24));

  // Bottom corners only
  static BorderRadius get bottom4 =>
      const BorderRadius.vertical(bottom: Radius.circular(4));
  static BorderRadius get bottom8 =>
      const BorderRadius.vertical(bottom: Radius.circular(8));
  static BorderRadius get bottom12 =>
      const BorderRadius.vertical(bottom: Radius.circular(12));
  static BorderRadius get bottom16 =>
      const BorderRadius.vertical(bottom: Radius.circular(16));
  static BorderRadius get bottom24 =>
      const BorderRadius.vertical(bottom: Radius.circular(24));

  // Left corners only
  static BorderRadius get left4 =>
      const BorderRadius.horizontal(left: Radius.circular(4));
  static BorderRadius get left8 =>
      const BorderRadius.horizontal(left: Radius.circular(8));
  static BorderRadius get left12 =>
      const BorderRadius.horizontal(left: Radius.circular(12));
  static BorderRadius get left16 =>
      const BorderRadius.horizontal(left: Radius.circular(16));

  // Right corners only
  static BorderRadius get right4 =>
      const BorderRadius.horizontal(right: Radius.circular(4));
  static BorderRadius get right8 =>
      const BorderRadius.horizontal(right: Radius.circular(8));
  static BorderRadius get right12 =>
      const BorderRadius.horizontal(right: Radius.circular(12));
  static BorderRadius get right16 =>
      const BorderRadius.horizontal(right: Radius.circular(16));

  // Common UI element radiuses
  static BorderRadius get button => circular8;
  static BorderRadius get card => circular16;
  static BorderRadius get bottomSheet => top24;
  static BorderRadius get dialog => circular20;
  static BorderRadius get tooltip => circular4;
  static BorderRadius get checkbox => circular4;
  static BorderRadius get chip => circular32;

  // Custom radius helpers
  static BorderRadius custom({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }

  static BorderRadius symmetricVertical({
    required double top,
    required double bottom,
  }) {
    return BorderRadius.vertical(
      top: Radius.circular(top),
      bottom: Radius.circular(bottom),
    );
  }

  static BorderRadius symmetricHorizontal({
    required double left,
    required double right,
  }) {
    return BorderRadius.horizontal(
      left: Radius.circular(left),
      right: Radius.circular(right),
    );
  }
}

// Extension for easier usage with widgets
extension BorderRadiusExtensions on Widget {
  Widget withRadius(BorderRadius radius) => ClipRRect(
        borderRadius: radius,
        child: this,
      );

  Widget withCircularRadius(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );
}
