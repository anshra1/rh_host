part of 'import.dart';

/// Design tokens for spacing used throughout the app
abstract class Spacing {
  // Base spacing units (based on 4pt grid)
  static double get xxxs => 2.w; // 2dp
  static double get xxs => 4.w; // 4dp
  static double get xs => 8.w; // 8dp
  static double get sm => 12.w; // 12dp
  static double get md => 16.w; // 16dp
  static double get lg => 24.w; // 24dp
  static double get xl => 32.w; // 32dp
  static double get xxl => 40.w; // 40dp
  static double get xxxl => 48.w; // 48dp

  // Component specific spacing
  static double get buttonSpacing => sm;
  static double get cardPadding => md;
  static double get listItemSpacing => xs;
  static double get sectionSpacing => xl;
  static double get screenMargin => md;

  // Layout spacing
  static EdgeInsets get screenPadding => EdgeInsets.all(screenMargin);
  static EdgeInsets get contentPadding => EdgeInsets.all(md);
  static EdgeInsets get cardInnerPadding => EdgeInsets.all(cardPadding);

  // Gaps
  static Gap get gapXS => Gap(xs);
  static Gap get gapSM => Gap(sm);
  static Gap get gapMD => Gap(md);
  static Gap get gapLG => Gap(lg);
  static Gap get gapXL => Gap(xl);
  static Gap get gapXXL => Gap(xxl);

  // Custom gaps
  static Gap height(double height) => Gap(height);
  static Gap width(double width) => Gap(width);
}
