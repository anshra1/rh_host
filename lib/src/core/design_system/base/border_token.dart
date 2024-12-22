import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

abstract class BorderTokens {
  static Border defaultBorder = Border.all(
    color: LightColorsToken.border,
  );

  static Border focusedBorder = Border.all(
    color: LightColorsToken.borderFocus,
    width: AppSize.borderMedium2,
  );

  static Border errorBorder = Border.all(
    color: LightColorsToken.borderError,
    width: AppSize.borderMedium2,
  );
}
