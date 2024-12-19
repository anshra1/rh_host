// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

abstract class BorderTokens {
  static Border defaultBorder = Border.all(
    color: AppColors.border,
    width: AppSize.borderThin,
  );

  static Border focusedBorder = Border.all(
    color: AppColors.borderFocus,
    width: AppSize.borderMedium,
  );

  static Border errorBorder = Border.all(
    color: AppColors.borderError,
    width: AppSize.borderMedium,
  );
}
