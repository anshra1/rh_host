import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';

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
  static const List<BoxShadow> shadow1 = [
    BoxShadow(
      color: LightColorsToken.shadowLight,
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> shadow2 = [
    BoxShadow(
      color: LightColorsToken.shadowLight,
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadow3 = [
    BoxShadow(
      color: LightColorsToken.shadowLight,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> shadow4 = [
    BoxShadow(
      color: LightColorsToken.shadowLight,
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> shadow5 = [
    BoxShadow(
      color: LightColorsToken.shadowLight,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
}
