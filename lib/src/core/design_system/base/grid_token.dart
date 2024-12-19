abstract class GridTokens {
  // Column configuration
  static const int columns = 12;
  static const double columnSpacing = 16;
  static const double gutterWidth = 24;

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 960;
  static const double desktopBreakpoint = 1280;
  static const double wideDesktopBreakpoint = 1920;

  // Content width constraints
  static const double maxContentWidth = 1440;
  static const double minContentWidth = 320;

  // Container margins
  static double getMargin(double screenWidth) {
    if (screenWidth >= wideDesktopBreakpoint) return 24;
    if (screenWidth >= desktopBreakpoint) return 24;
    if (screenWidth >= tabletBreakpoint) return 16;
    return 16;
  }
}
