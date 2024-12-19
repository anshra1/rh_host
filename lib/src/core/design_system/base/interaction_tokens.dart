abstract class InteractionTokens {
  // Touch targets
  static const double minTouchTargetSize = 48;
  static const double minInteractiveElementSpacing = 8;

  // Press states
  static const double pressedStateOpacity = 0.7;
  static const double disabledStateOpacity = 0.5;

  // Focus rings
  static const double focusRingWidth = 2;
  static const double focusRingOffset = 2;

  // Hover effects
  static const double hoverScaleEffect = 1.02;
  static const double hoverOpacityEffect = 0.8;

  // Scroll
  static const double scrollbarThickness = 8;
  static const double scrollbarRadius = 4;
  static const Duration scrollAnimationDuration = Duration(milliseconds: 300);
}

// lib/src/design/tokens/responsive_tokens.dart
abstract class ResponsiveTokens {
  // Screen size breakpoints
  static const double mobileS = 320;
  static const double mobileM = 375;
  static const double mobileL = 425;
  static const double tablet = 768;
  static const double laptop = 1024;
  static const double laptopL = 1440;
  static const double desktop = 2560;

  // Orientation breakpoints
  static const double portraitBreakpoint = 600;
  static const double landscapeBreakpoint = 960;

  // Content scaling factors
  static double getScalingFactor(double screenWidth) {
    if (screenWidth >= desktop) return 1.2;
    if (screenWidth >= laptopL) return 1.1;
    if (screenWidth >= laptop) return 1;
    if (screenWidth >= tablet) return 0.9;
    return 0.8;
  }

  // Aspect ratios
  static const double mobileAspectRatio = 9 / 16;
  static const double tabletAspectRatio = 3 / 4;
  static const double desktopAspectRatio = 16 / 9;
}

// lib/src/design/tokens/z_index_tokens.dart
abstract class ZIndexTokens {
  static const double base = 0;
  static const double dropdown = 1000;
  static const double sticky = 1020;
  static const double fixed = 1030;
  static const double modalBackdrop = 1040;
  static const double modal = 1050;
  static const double popover = 1060;
  static const double tooltip = 1070;
  static const double toast = 1080;
}
