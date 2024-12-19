// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSize {
  // Icon sizes
  static double get iconXS => 12.w;
  static double get iconSM => 16.w;
  static double get iconMD => 24.w;
  static double get iconLG => 32.w;
  static double get iconXL => 40.w;

  // Button heights
  static double get buttonSM => 32.h;
  static double get buttonMD => 40.h;
  static double get buttonLG => 48.h;

  // Input field heights
  static double get inputSM => 32.h;
  static double get inputMD => 40.h;
  static double get inputLG => 48.h;

  // Component heights
  static double get appBar => 56.h;
  static double get bottomNav => 80.h;
  static double get tabBar => 48.h;
  static double get drawer => 256.w;
  static double get modal => 0.9.sh;
  static double get snackbar => 48.h;
  static double get tooltip => 32.h;

  // Border radius
  static double get radiusXS => 2.r;
  static double get radiusSM => 4.r;
  static double get radiusMD => 8.r;
  static double get radiusLG => 16.r;
  static double get radiusXL => 24.r;
  static double get radiusCircle => 999.r;

  // Border widths
  static double get borderThin => 1;
  static double get borderMedium => 2;
  static double get borderThick => 4;

  // Minimum touch targets
  static double get minTouchTarget => 48.w;
  static double get minButtonWidth => 64.w;
  static double get maxButtonWidth => 312.w;
}
