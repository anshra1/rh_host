// import 'package:flutter/material.dart';
// import 'package:rh_host/src/core/design_system/base/accessibilty_token.dart';
// import 'package:rh_host/src/core/design_system/base/app_font.dart';
// import 'package:rh_host/src/core/design_system/base/border_token.dart';
// import 'package:rh_host/src/core/design_system/base/device_token.dart';
// import 'package:rh_host/src/core/design_system/base/elevation.dart';
// import 'package:rh_host/src/core/design_system/base/grid_token.dart';
// import 'package:rh_host/src/core/design_system/base/import.dart';
// import 'package:rh_host/src/core/design_system/base/interaction_tokens.dart';
// import 'package:rh_host/src/core/design_system/base/layout_token.dart';
// import 'package:rh_host/src/core/design_system/base/motion.dart';
// import 'package:rh_host/src/core/design_system/base/responsive_token.dart';
// import 'package:rh_host/src/core/design_system/base/sementic_token.dart';
// import 'package:rh_host/src/core/design_system/base/size.dart';
// import 'package:rh_host/src/core/design_system/base/z_index_token.dart';

// /// A centralized class that consolidates access to all design tokens
// class DS {
//   DS(this.s);
//   final String? s;
//   static AppColors colors = AppColors.instance;
//   static AppFonts fonts = AppFonts.instance;
//   static ElevationTokens elevation = ElevationTokens.instance;
//   static MotionTokens motion = MotionTokens.instance;
//   static LayoutTokens layout = LayoutTokens.instance;
//   static GridTokens grid = GridTokens.instance;
//   static ResponsiveTokens responsive = ResponsiveTokens.instance;
//   static SemanticTokens semantic = SemanticTokens.instance;
//   static AppSize size = AppSize.instance;
//   static Spacing spacing = Spacing.instance;
//   static ZIndexTokens zIndex = ZIndexTokens.instance;
//   static AccessibilityTokens accessibility = AccessibilityTokens.instance;
//   static BorderTokens border = BorderTokens.instance;
//   static DeviceTokens device = DeviceTokens.instance;
//   static InteractionTokens interaction = InteractionTokens.instance;
//   //static PlatformTokens platform = PlatformToken.instance;
//   // Theme-specific tokens
//   static ThemeSpecificTokens of(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return ThemeSpecificTokens(isDark: isDark);
//   }
// }

// /// Tokens that change based on theme
// class ThemeSpecificTokens {
//   const ThemeSpecificTokens({required this.isDark});

//   final bool isDark;

//   Color get shadowColor => isDark
//       ? Colors.black.withAlpha((0.24 * 255).toInt())
//       : Colors.black.withAlpha((0.12 * 255).toInt());

//   Color get dividerColor => isDark
//       ? Colors.white.withAlpha((0.12 * 255).toInt())
//       : Colors.black.withAlpha((0.12 * 255).toInt());

//   Color get overlayColor => isDark
//       ? Colors.white.withAlpha((0.08 * 255).toInt())
//       : Colors.black.withAlpha((0.04 * 255).toInt());
// }
