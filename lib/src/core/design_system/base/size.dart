// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  // Icon sizes
  static final iconXS12 = 12.w;
  static final iconSM16 = 16.w;
  static final iconMD24 = 24.w;
  static final iconLG32 = 32.w;
  static final iconXL40 = 40.w;

  // Button heights
  static final buttonSM32 = 32.h;
  static final buttonMD40 = 40.h;
  static final buttonLG48 = 48.h;

  // Input field heights
  static final inputSM32 = 32.h;
  static final inputMD40 = 40.h;
  static final inputLG48 = 48.h;

  // Component heights
  static final appBar56 = 56.h;
  static final bottomNav80 = 80.h;
  static final tabBar48 = 48.h;
  static final drawer256 = 256.w;
  static final modal90 = 0.9.sh;
  static final snackbar48 = 48.h;
  static final tooltip32 = 32.h;

  // Border radius
  static final radiusXS2 = 2.r;
  static final radiusSM4 = 4.r;
  static final radiusMD8 = 8.r;
  static final radiusLG16 = 16.r;
  static final radiusXL24 = 24.r;
  static final radiusCircle999 = 999.r;

  // Border widths - These don't need responsive scaling
  static const borderThin1 = 1.0;
  static const borderMedium2 = 2.0;
  static const borderThick4 = 4.0;

  // Minimum touch targets
  static final minTouchTarget48 = 48.w;
  static final minButtonWidth64 = 64.w;
  static final maxButtonWidth312 = 312.w;

  static double radiusCircle = 999.r;
}
