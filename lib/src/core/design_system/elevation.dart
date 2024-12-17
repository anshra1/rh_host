import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/import.dart';

/// Design tokens for elevation and shadow styles
abstract class ElevationTokens {
  // Elevation levels
  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 2;
  static const double level3 = 4;
  static const double level4 = 6;
  static const double level5 = 8;

  // Shadow styles
  static List<BoxShadow> get shadow1 => [
        const BoxShadow(
          color: AppColor.shadowLight,
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get shadow2 => [
        const BoxShadow(
          color: AppColor.shadowLight,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadow3 => [
        const BoxShadow(
          color: AppColor.shadowLight,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadow4 => [
        const BoxShadow(
          color: AppColor.shadowLight,
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get shadow5 => [
        const BoxShadow(
          color: AppColor.shadowLight,
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ];
}
