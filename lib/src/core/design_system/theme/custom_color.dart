 import 'package:flutter/material.dart';

 @immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.border,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color border;

  // Required override to support copying theme with modified values
  @override
  CustomColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? border,
  }) {
    return CustomColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      border: border ?? this.border,
    );
  }

  // Required override to support theme lerping (smooth transitions)
  @override
  CustomColors lerp(CustomColors? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

// @immutable
// class CustomColors extends ThemeExtension<CustomColors> {
//   const CustomColors({
//     // Text Colors
//     this.textPrimary,
//     this.textSecondary,
//     this.textDisabled,
//     this.textError,
//     this.textLink,
//     this.textInverse,

//     // Background Colors
//     this.backgroundMain,
//     this.backgroundSecondary,
//     this.backgroundCard,
//     this.backgroundModal,
//     this.backgroundElevated,

//     // Button Colors
//     this.buttonPrimaryBg,
//     this.buttonPrimaryText,
//     this.buttonSecondaryBg,
//     this.buttonSecondaryText,
//     this.buttonOutlineBorder,
//     this.buttonDisabled,

//     // Icon Colors
//     this.iconPrimary,
//     this.iconSecondary,
//     this.iconInteractive,
//     this.iconDisabled,
//     this.iconError,

//     // Border & Divider Colors
//     this.borderDefault,
//     this.borderFocus,
//     this.borderError,
//     this.divider,

//     // Input Field Colors
//     this.inputLabel,
//     this.inputText,
//     this.inputHelper,
//     this.inputError,
//     this.inputFilled,

//     // State Colors
//     this.stateError,
//     this.stateSuccess,
//     this.stateWarning,
//     this.stateInfo,

//     // Navigation Colors
//     this.navSelected,
//     this.navUnselected,
//     this.navBackground,

//     // Chip Colors
//     this.chipBackground,
//     this.chipSelectedBg,
//     this.chipText,
//     this.chipSelectedText,
//   });

//   // Text Colors
//   final Color? textPrimary;
//   final Color? textSecondary;
//   final Color? textDisabled;
//   final Color? textError;
//   final Color? textLink;
//   final Color? textInverse;

//   // Backgrou?nd Colors
//   final Color? backgroundMain;
//   final Color? backgroundSecondary;
//   final Color? backgroundCard;
//   final Color? backgroundModal;
//   final Color? backgroundElevated;

//   // Button C?olors
//   final Color? buttonPrimaryBg;
//   final Color? buttonPrimaryText;
//   final Color? buttonSecondaryBg;
//   final Color? buttonSecondaryText;
//   final Color? buttonOutlineBorder;
//   final Color? buttonDisabled;

//   // Icon Col?ors
//   final Color? iconPrimary;
//   final Color? iconSecondary;
//   final Color? iconInteractive;
//   final Color? iconDisabled;
//   final Color? iconError;

//   // Border &? Divider Colors
//   final Color? borderDefault;
//   final Color? borderFocus;
//   final Color? borderError;
//   final Color? divider;

//   // Input Fi?eld Colors
//   final Color? inputLabel;
//   final Color? inputText;
//   final Color? inputHelper;
//   final Color? inputError;
//   final Color? inputFilled;

//   // State Co?lors
//   final Color? stateError;
//   final Color? stateSuccess;
//   final Color? stateWarning;
//   final Color? stateInfo;

//   // Navigati?on Colors
//   final Color? navSelected;
//   final Color? navUnselected;
//   final Color? navBackground;

//   // Chip Col?ors
//   final Color? chipBackground;
//   final Color? chipSelectedBg;
//   final Color? chipText;
//   final Color? chipSelectedText;

//   @override
//   CustomColors copyWith({
//     Color? textPrimary,
//     Color? textSecondary,
//     Color? textDisabled,
//     Color? textError,
//     Color? textLink,
//     Color? textInverse,
//     Color? backgroundMain,
//     Color? backgroundSecondary,
//     Color? backgroundCard,
//     Color? backgroundModal,
//     Color? backgroundElevated,
//     Color? buttonPrimaryBg,
//     Color? buttonPrimaryText,
//     Color? buttonSecondaryBg,
//     Color? buttonSecondaryText,
//     Color? buttonOutlineBorder,
//     Color? buttonDisabled,
//     Color? iconPrimary,
//     Color? iconSecondary,
//     Color? iconInteractive,
//     Color? iconDisabled,
//     Color? iconError,
//     Color? borderDefault,
//     Color? borderFocus,
//     Color? borderError,
//     Color? divider,
//     Color? inputLabel,
//     Color? inputText,
//     Color? inputHelper,
//     Color? inputError,
//     Color? inputFilled,
//     Color? stateError,
//     Color? stateSuccess,
//     Color? stateWarning,
//     Color? stateInfo,
//     Color? navSelected,
//     Color? navUnselected,
//     Color? navBackground,
//     Color? chipBackground,
//     Color? chipSelectedBg,
//     Color? chipText,
//     Color? chipSelectedText,
//   }) {
//     return CustomColors(
//       textPrimary: textPrimary ?? this.textPrimary,
//       textSecondary: textSecondary ?? this.textSecondary,
//       textDisabled: textDisabled ?? this.textDisabled,
//       textError: textError ?? this.textError,
//       textLink: textLink ?? this.textLink,
//       textInverse: textInverse ?? this.textInverse,
//       backgroundMain: backgroundMain ?? this.backgroundMain,
//       backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
//       backgroundCard: backgroundCard ?? this.backgroundCard,
//       backgroundModal: backgroundModal ?? this.backgroundModal,
//       backgroundElevated: backgroundElevated ?? this.backgroundElevated,
//       buttonPrimaryBg: buttonPrimaryBg ?? this.buttonPrimaryBg,
//       buttonPrimaryText: buttonPrimaryText ?? this.buttonPrimaryText,
//       buttonSecondaryBg: buttonSecondaryBg ?? this.buttonSecondaryBg,
//       buttonSecondaryText: buttonSecondaryText ?? this.buttonSecondaryText,
//       buttonOutlineBorder: buttonOutlineBorder ?? this.buttonOutlineBorder,
//       buttonDisabled: buttonDisabled ?? this.buttonDisabled,
//       iconPrimary: iconPrimary ?? this.iconPrimary,
//       iconSecondary: iconSecondary ?? this.iconSecondary,
//       iconInteractive: iconInteractive ?? this.iconInteractive,
//       iconDisabled: iconDisabled ?? this.iconDisabled,
//       iconError: iconError ?? this.iconError,
//       borderDefault: borderDefault ?? this.borderDefault,
//       borderFocus: borderFocus ?? this.borderFocus,
//       borderError: borderError ?? this.borderError,
//       divider: divider ?? this.divider,
//       inputLabel: inputLabel ?? this.inputLabel,
//       inputText: inputText ?? this.inputText,
//       inputHelper: inputHelper ?? this.inputHelper,
//       inputError: inputError ?? this.inputError,
//       inputFilled: inputFilled ?? this.inputFilled,
//       stateError: stateError ?? this.stateError,
//       stateSuccess: stateSuccess ?? this.stateSuccess,
//       stateWarning: stateWarning ?? this.stateWarning,
//       stateInfo: stateInfo ?? this.stateInfo,
//       navSelected: navSelected ?? this.navSelected,
//       navUnselected: navUnselected ?? this.navUnselected,
//       navBackground: navBackground ?? this.navBackground,
//       chipBackground: chipBackground ?? this.chipBackground,
//       chipSelectedBg: chipSelectedBg ?? this.chipSelectedBg,
//       chipText: chipText ?? this.chipText,
//       chipSelectedText: chipSelectedText ?? this.chipSelectedText,
//     );
//   }

//   @override
//   CustomColors lerp(CustomColors? other, double t) {
//     if (other is! CustomColors) return this;

//     return CustomColors(
//       textPrimary: Color.lerp(textPrimary, other.textPrimary, t),
//       textSecondary: Color.lerp(textSecondary, other.textSecondary, t),
//       textDisabled: Color.lerp(textDisabled, other.textDisabled, t),
//       textError: Color.lerp(textError, other.textError, t),
//       textLink: Color.lerp(textLink, other.textLink, t),
//       textInverse: Color.lerp(textInverse, other.textInverse, t),
//       backgroundMain: Color.lerp(backgroundMain, other.backgroundMain, t),
//       backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t),
//       backgroundCard: Color.lerp(backgroundCard, other.backgroundCard, t),
//       backgroundModal: Color.lerp(backgroundModal, other.backgroundModal, t),
//       backgroundElevated: Color.lerp(backgroundElevated, other.backgroundElevated, t),
//       buttonPrimaryBg: Color.lerp(buttonPrimaryBg, other.buttonPrimaryBg, t),
//       buttonPrimaryText: Color.lerp(buttonPrimaryText, other.buttonPrimaryText, t),
//       buttonSecondaryBg: Color.lerp(buttonSecondaryBg, other.buttonSecondaryBg, t),
//       buttonSecondaryText: Color.lerp(buttonSecondaryText, other.buttonSecondaryText, t),
//       buttonOutlineBorder: Color.lerp(buttonOutlineBorder, other.buttonOutlineBorder, t),
//       buttonDisabled: Color.lerp(buttonDisabled, other.buttonDisabled, t),
//       iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t),
//       iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t),
//       iconInteractive: Color.lerp(iconInteractive, other.iconInteractive, t),
//       iconDisabled: Color.lerp(iconDisabled, other.iconDisabled, t),
//       iconError: Color.lerp(iconError, other.iconError, t),
//       borderDefault: Color.lerp(borderDefault, other.borderDefault, t),
//       borderFocus: Color.lerp(borderFocus, other.borderFocus, t),
//       borderError: Color.lerp(borderError, other.borderError, t),
//       divider: Color.lerp(divider, other.divider, t),
//       inputLabel: Color.lerp(inputLabel, other.inputLabel, t),
//       inputText: Color.lerp(inputText, other.inputText, t),
//       inputHelper: Color.lerp(inputHelper, other.inputHelper, t),
//       inputError: Color.lerp(inputError, other.inputError, t),
//       inputFilled: Color.lerp(inputFilled, other.inputFilled, t),
//       stateError: Color.lerp(stateError, other.stateError, t),
//       stateSuccess: Color.lerp(stateSuccess, other.stateSuccess, t),
//       stateWarning: Color.lerp(stateWarning, other.stateWarning, t),
//       stateInfo: Color.lerp(stateInfo, other.stateInfo, t),
//       navSelected: Color.lerp(navSelected, other.navSelected, t),
//       navUnselected: Color.lerp(navUnselected, other.navUnselected, t),
//       navBackground: Color.lerp(navBackground, other.navBackground, t),
//       chipBackground: Color.lerp(chipBackground, other.chipBackground, t),
//       chipSelectedBg: Color.lerp(chipSelectedBg, other.chipSelectedBg, t),
//       chipText: Color.lerp(chipText, other.chipText, t),
//       chipSelectedText: Color.lerp(chipSelectedText, other.chipSelectedText, t),
//     );
//   }
// }
