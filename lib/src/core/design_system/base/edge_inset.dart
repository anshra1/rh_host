import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEdgeInsets {
  // All sides
  static const EdgeInsets all2 = EdgeInsets.all(2);
  static const EdgeInsets all4 = EdgeInsets.all(4);
  static const EdgeInsets all6 = EdgeInsets.all(6);
  static const EdgeInsets all8 = EdgeInsets.all(8);
  static const EdgeInsets all12 = EdgeInsets.all(12);
  static const EdgeInsets all16 = EdgeInsets.all(16);
  static const EdgeInsets all20 = EdgeInsets.all(20);
  static const EdgeInsets all24 = EdgeInsets.all(24);

  // Horizontal
  static const EdgeInsets h4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets h8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets h12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets h16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets h20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets h24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets h32 = EdgeInsets.symmetric(horizontal: 32);

  // Vertical
  static const EdgeInsets v4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets v8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets v12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets v16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets v20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets v24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets v32 = EdgeInsets.symmetric(vertical: 32);

  // Specific sides
  static const EdgeInsets l2 = EdgeInsets.only(left: 2);
  static const EdgeInsets l4 = EdgeInsets.only(left: 4);
  static const EdgeInsets l8 = EdgeInsets.only(left: 8);
  static const EdgeInsets l16 = EdgeInsets.only(left: 16);
  static const EdgeInsets r2 = EdgeInsets.only(right: 2);
  static const EdgeInsets r4 = EdgeInsets.only(right: 4);
  static const EdgeInsets r8 = EdgeInsets.only(right: 8);
  static const EdgeInsets r16 = EdgeInsets.only(right: 16);
  static const EdgeInsets t2 = EdgeInsets.only(top: 2);
  static const EdgeInsets t4 = EdgeInsets.only(top: 4);
  static const EdgeInsets t8 = EdgeInsets.only(top: 8);
  static const EdgeInsets t16 = EdgeInsets.only(top: 16);
  static const EdgeInsets b2 = EdgeInsets.only(bottom: 2);
  static const EdgeInsets b4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets b8 = EdgeInsets.only(bottom: 8);
  static const EdgeInsets b16 = EdgeInsets.only(bottom: 16);

  // List spacing
  static EdgeInsets get listItemPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      );
  static EdgeInsets get listSeparatorPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
      );

  // Form spacing
  static EdgeInsets get formFieldPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      );
  static EdgeInsets get formGroupPadding => EdgeInsets.only(bottom: 24.h);

  // Card spacing
  static EdgeInsets get cardPadding => EdgeInsets.all(16.r);
  static EdgeInsets get cardContentPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      );

  // Dialog spacing
  static EdgeInsets get dialogPadding => EdgeInsets.all(24.r);
  static EdgeInsets get dialogContentPadding => EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      );

  // Bottom sheet spacing
  static EdgeInsets get bottomSheetPadding => EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 32.h,
        top: 8.h,
      );
}
