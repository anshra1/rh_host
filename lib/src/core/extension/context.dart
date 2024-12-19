// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  //
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  Orientation get orientation => mediaQuery.orientation;

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  // Show dialogs and bottom sheets
  Future<T?> showAppDialog<T>({
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: content,
        actions: actions,
      ),
    );
  }

  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? AppColors.surface,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.radiusLG),
            ),
          ),
      builder: (_) => child,
    );
  }

  // Show snackbars
  void showSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
        action: action,
      ),
    );
  }

  void showErrorSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: AppColors.error,
        action: action,
      ),
    );
  }

  void showSuccessSnackBar(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 4),
        backgroundColor: AppColors.success,
        action: action,
      ),
    );
  }
}
