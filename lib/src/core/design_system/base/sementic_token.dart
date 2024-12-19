// Dart imports:
import 'dart:ui';

// Project imports:
import 'package:rh_host/src/core/design_system/base/import.dart';

abstract class SemanticTokens {
  // States
  static const success = AppColors.success;
  static const error = AppColors.error;
  static const info = AppColors.info;
  static const warning = AppColors.warning;

  // Interactive
  static const interactive = AppColors.primaryColorColor;
  static const interactiveHover = AppColors.primaryColorLight;
  static const interactivePressed = AppColors.primaryColorDark;
  static const interactiveDisabled = AppColors.neutral400;

  // Feedback
  static const positiveBackground = Color(0xFFE8F5E9);
  static const negativeBackground = Color(0xFFFFEBEE);
  static const warningBackground = Color(0xFFFFF3E0);
  static const infoBackground = Color(0xFFE3F2FD);
}
