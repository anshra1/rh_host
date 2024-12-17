import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/import.dart';
import 'package:rh_host/src/core/design_system/size.dart';

abstract class BorderTokens {
  static Border defaultBorder = Border.all(
    color: AppColor.border,
    width: AppSize.borderThin,
  );

  static Border focusedBorder = Border.all(
    color: AppColor.borderFocus,
    width: AppSize.borderMedium,
  );

  static Border errorBorder = Border.all(
    color: AppColor.borderError,
    width: AppSize.borderMedium,
  );
}
