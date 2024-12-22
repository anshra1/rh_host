// Dart imports:
import 'dart:ui';

import 'package:rh_host/src/core/design_system/base/import.dart';

abstract class SemanticTokens {
  // States
  static const success = LightColorsToken.success;
  static const error = LightColorsToken.error;
  static const info = LightColorsToken.info;
  static const warning = LightColorsToken.warning;

  // Interactive
  static const interactive = LightColorsToken.primaryLight;
  static const interactiveHover = LightColorsToken.primaryLight;
  static const interactivePressed = LightColorsToken.primaryDark;
  static const interactiveDisabled = LightColorsToken.neutral400;

  // Feedback
  static const positiveBackground = Color(0xFFE8F5E9);
  static const negativeBackground = Color(0xFFFFEBEE);
  static const warningBackground = Color(0xFFFFF3E0);
  static const infoBackground = Color(0xFFE3F2FD);
}
