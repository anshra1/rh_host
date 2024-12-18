import 'dart:ui';
import 'package:rh_host/src/core/design_system/z_import.dart';

abstract class SemanticTokens {
  // States
  static const success = AppColor.success;
  static const error = AppColor.error;
  static const info = AppColor.info;
  static const warning = AppColor.warning;

  // Interactive
  static const interactive = AppColor.primaryColor;
  static const interactiveHover = AppColor.primaryLight;
  static const interactivePressed = AppColor.primaryDark;
  static const interactiveDisabled = AppColor.neutral400;

  // Feedback
  static const positiveBackground = Color(0xFFE8F5E9);
  static const negativeBackground = Color(0xFFFFEBEE);
  static const warningBackground = Color(0xFFFFF3E0);
  static const infoBackground = Color(0xFFE3F2FD);
}
