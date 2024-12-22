import 'package:flutter/material.dart';
import 'package:rh_host/src/core/extension/context.dart';

abstract class AppColors {
  // Text Colors
  static Color textPrimary(BuildContext context) => context.theme.colorScheme.onSurface;
  static Color textSecondary(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color textDisabled(BuildContext context) =>
      context.theme.colorScheme.onSurface.withAlpha((0.38 * 255).toInt());
  static Color textError(BuildContext context) => context.theme.colorScheme.error;
  static Color textLink(BuildContext context) => context.theme.colorScheme.primary;
  static Color textInverse(BuildContext context) => context.theme.colorScheme.onPrimary;

  // Background Colors
  static Color backgroundMain(BuildContext context) => context.theme.colorScheme.surface;
  static Color backgroundSecondary(BuildContext context) =>
      context.theme.colorScheme.surfaceContainerHighest;
  static Color backgroundCard(BuildContext context) => context.theme.colorScheme.surface;
  static Color backgroundModal(BuildContext context) => context.theme.colorScheme.surface;
  static Color backgroundElevated(BuildContext context) =>
      context.theme.colorScheme.surface;

  // Button Colors
  static Color buttonPrimaryBg(BuildContext context) => context.theme.colorScheme.primary;
  static Color buttonPrimaryText(BuildContext context) =>
      context.theme.colorScheme.onPrimary;
  static Color buttonSecondaryBg(BuildContext context) =>
      context.theme.colorScheme.secondary;
  static Color buttonSecondaryText(BuildContext context) =>
      context.theme.colorScheme.onSecondary;
  static Color buttonOutlineBorder(BuildContext context) =>
      context.theme.colorScheme.outline;
  static Color buttonDisabled(BuildContext context) =>
      context.theme.colorScheme.onSurface.withAlpha((0.12 * 255).toInt());

  // Icon Colors
  static Color iconPrimary(BuildContext context) => context.theme.colorScheme.onSurface;
  static Color iconSecondary(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color iconInteractive(BuildContext context) => context.theme.colorScheme.primary;
  static Color iconDisabled(BuildContext context) =>
      context.theme.colorScheme.onSurface.withAlpha((0.38 * 255).toInt());
  static Color iconError(BuildContext context) => context.theme.colorScheme.error;

  // Border & Divider Colors
  static Color borderDefault(BuildContext context) => context.theme.colorScheme.outline;
  static Color borderFocus(BuildContext context) => context.theme.colorScheme.primary;
  static Color borderError(BuildContext context) => context.theme.colorScheme.error;
  static Color divider(BuildContext context) => context.theme.colorScheme.outlineVariant;

  // Input Field Colors
  static Color inputLabel(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color inputText(BuildContext context) => context.theme.colorScheme.onSurface;
  static Color inputHelper(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color inputError(BuildContext context) => context.theme.colorScheme.error;
  static Color inputFilled(BuildContext context) =>
      context.theme.colorScheme.surfaceContainerHighest;

  // State Colors
  static Color stateError(BuildContext context) => context.theme.colorScheme.error;
  static Color stateSuccess(BuildContext context) => context.theme.colorScheme.primary;
  static Color stateWarning(BuildContext context) => context.theme.colorScheme.secondary;
  static Color stateInfo(BuildContext context) => context.theme.colorScheme.tertiary;

  // Navigation Colors
  static Color navSelected(BuildContext context) => context.theme.colorScheme.primary;
  static Color navUnselected(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color navBackground(BuildContext context) => context.theme.colorScheme.surface;

  // Chip Colors
  static Color chipBackground(BuildContext context) =>
      context.theme.colorScheme.surfaceContainerHighest;
  static Color chipSelectedBg(BuildContext context) =>
      context.theme.colorScheme.secondaryContainer;
  static Color chipText(BuildContext context) =>
      context.theme.colorScheme.onSurfaceVariant;
  static Color chipSelectedText(BuildContext context) =>
      context.theme.colorScheme.onSecondaryContainer;

  // Overlay Colors
  static Color overlayModal(BuildContext context) => context.theme.colorScheme.scrim;
  static Color overlayDisabled(BuildContext context) =>
      context.theme.colorScheme.onSurface.withAlpha((0.12 * 255).toInt());
  static Color overlayPressed(BuildContext context) =>
      context.theme.colorScheme.primary.withAlpha((0.12 * 255).toInt());
  static Color overlayHover(BuildContext context) =>
      context.theme.colorScheme.primary.withAlpha((0.08 * 255).toInt());
  static Color overlayFocus(BuildContext context) =>
      context.theme.colorScheme.primary.withAlpha((0.12 * 255).toInt());

  // System Bar Colors
  static Color statusBar(BuildContext context) => context.theme.colorScheme.primary;
  static Color navigationBar(BuildContext context) => context.theme.colorScheme.surface;

  // Opacity Constants
  static const double opacityDisabled = 0.38;
  static const double opacitySecondaryText = 0.6;
  static const double opacityHintText = 0.38;
  static const double opacityDividers = 0.12;
  static const double opacityHover = 0.08;
  static const double opacityFocus = 0.12;
  static const double opacityPressed = 0.12;
}
