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
