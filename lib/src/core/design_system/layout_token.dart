

abstract class LayoutTokens {
  // Common aspect ratios
  static const double aspectRatioSquare = 1;
  static const double aspectRatio4_3 = 4/3;
  static const double aspectRatio16_9 = 16/9;
  
  // Layout grid
  static const double gridBaseUnit = 8;
  static const int gridColumns = 12;
  
  // Safe area
  // static EdgeInsets get defaultSafeArea => const EdgeInsets.only(
  //   // top: MediaQuery.of(navigatorKey.currentContext!).padding.top,
  //   // bottom: MediaQuery.of(navigatorKey.currentContext!).padding.bottom,
  // );
  
  // Common layout constraints
  static const double maxContentWidth = 1200;
  static const double minContentPadding = 16;
}