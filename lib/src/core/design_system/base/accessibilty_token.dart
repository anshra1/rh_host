// lib/src/design/tokens/accessibility_tokens.dart

// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:rh_host/src/core/design_system/base/import.dart';

abstract class AccessibilityTokens {
  // Minimum contrast ratios
  static const double minContrastRatioNormal = 4.5;
  static const double minContrastRatioLarge = 3;

  // Minimum touch targets
  static const double minTouchTargetSize = 48;
  static const double minTouchTargetSpacing = 8;

  // Focus indicators
  static const double focusRingWidth = 2;
  static const Color focusRingColor = AppColors.primaryColor;

  // Animation settings
  static const bool reduceMotion = false;
  static const Duration maxAnimationDuration = Duration(milliseconds: 400);
}
