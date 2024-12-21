// Flutter imports:
import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        action: action,
        duration: duration ?? const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMD),
        ),
        margin: EdgeInsets.all(Spacing.md),
      ),
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        action: action,
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMD),
        ),
        margin: EdgeInsets.all(Spacing.md),
      ),
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textInverse,
          ),
        ),
        action: action,
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusMD),
        ),
        margin: EdgeInsets.all(Spacing.md),
      ),
    );
  }
}