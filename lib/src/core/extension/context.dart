import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';
import 'package:rh_host/src/core/design_system/theme/custom_color.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  TextTheme get textStyle => theme.textTheme;

  //
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  Orientation get orientation => mediaQuery.orientation;

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  CustomColors get customColors => Theme.of(this).extension<CustomColors>()!;

  // Text Colors
  Color get textPrimary => theme.colorScheme.onSurface;
  Color get textSecondary => theme.colorScheme.onSurfaceVariant;
  Color get textDisabled => theme.colorScheme.onSurface.withAlpha((0.38 * 255).toInt());
  Color get textError => theme.colorScheme.error;
  Color get textLink => theme.colorScheme.primary;
  Color get textInverse => theme.colorScheme.onPrimary;

  // Background Colors
  Color get backgroundMain => theme.colorScheme.surface;
  Color get backgroundSecondary => theme.colorScheme.surfaceContainerHighest;
  Color get backgroundCard => theme.colorScheme.surface;
  Color get backgroundModal => theme.colorScheme.surface;
  Color get backgroundElevated => theme.colorScheme.surface;

  // Button Colors
  Color get buttonPrimaryBg => theme.colorScheme.primary;
  Color get buttonPrimaryText => theme.colorScheme.onPrimary;
  Color get buttonSecondaryBg => theme.colorScheme.secondary;
  Color get buttonSecondaryText => theme.colorScheme.onSecondary;
  Color get buttonOutlineBorder => theme.colorScheme.outline;
  Color get buttonDisabled => theme.colorScheme.onSurface.withAlpha((0.12 * 255).toInt());

  // Icon Colors
  Color get iconPrimary => theme.colorScheme.onSurface;
  Color get iconSecondary => theme.colorScheme.onSurfaceVariant;
  Color get iconInteractive => theme.colorScheme.primary;
  Color get iconDisabled => theme.colorScheme.onSurface.withAlpha((0.38 * 255).toInt());
  Color get iconError => theme.colorScheme.error;

  // Border & Divider Colors
  Color get borderDefault => theme.colorScheme.outline;
  Color get borderFocus => theme.colorScheme.primary;
  Color get borderError => theme.colorScheme.error;
  Color get divider => theme.colorScheme.outlineVariant;

  // Input Field Colors
  Color get inputLabel => theme.colorScheme.onSurfaceVariant;
  Color get inputText => theme.colorScheme.onSurface;
  Color get inputHelper => theme.colorScheme.onSurfaceVariant;
  Color get inputError => theme.colorScheme.error;
  Color get inputFilled => theme.colorScheme.surfaceContainerHighest;

  // State  theme.colorScheme
  Color get stateError => theme.colorScheme.error;
  Color get stateSuccess => theme.colorScheme.primary;
  Color get stateWarning => theme.colorScheme.secondary;
  Color get stateInfo => theme.colorScheme.tertiary;

  // Navigation  theme.colorScheme
  Color get navSelected => theme.colorScheme.primary;
  Color get navUnselected => theme.colorScheme.onSurfaceVariant;
  Color get navBackground => theme.colorScheme.surface;

  // Chip  theme.colorScheme
  Color get chipBackground => theme.colorScheme.surfaceContainerHighest;
  Color get chipSelectedBg => theme.colorScheme.secondaryContainer;
  Color get chipText => theme.colorScheme.onSurfaceVariant;
  Color get chipSelectedText => theme.colorScheme.onSecondaryContainer;

  // Overlay Colors
  Color get overlayModal => theme.colorScheme.scrim;
  Color get overlayDisabled =>
      theme.colorScheme.onSurface.withAlpha((0.12 * 255).toInt());
  Color get overlayPressed => theme.colorScheme.primary.withAlpha((0.12 * 255).toInt());
  Color get overlayHover => theme.colorScheme.primary.withAlpha((0.08 * 255).toInt());
  Color get overlayFocus => theme.colorScheme.primary.withAlpha((0.12 * 255).toInt());

  // System Bar  theme.colorScheme
  Color get statusBar => theme.colorScheme.primary;
  Color get navigationBar => theme.colorScheme.surface;

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
      backgroundColor: backgroundColor ?? LightColorsToken.surface,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.radiusLG16),
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
        backgroundColor: LightColorsToken.error,
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
        backgroundColor: LightColorsToken.success,
        action: action,
      ),
    );
  }
}
