part of 'import.dart';

/// Design tokens for spacing used throughout the app
abstract class Spacing {
  // Base spacing units (based on 4pt grid)
  static const double xxxs2 = 2; // 2dp
  static const double xxs4 = 4; // 4dp
  static const double xs8 = 8; // 8dp
  static const double sm12 = 12; // 12dp
  static const double md16 = 16; // 16dp
  static const double lg24 = 24; // 24dp
  static const double xl32 = 32; // 32dp
  static const double xxl40 = 40; // 40dp
  static const double xxxl48 = 48; // 48dp

  // Component specific spacing
  static const double buttonSpacing = sm12;
  static const double cardPadding = md16;
  static const double listItemSpacing = xs8;
  static const double sectionSpacing = xl32;
  static const double screenMargin = md16;

  // Layout spacing
  static const EdgeInsets screenPadding = EdgeInsets.all(screenMargin);
  static const EdgeInsets contentPadding = EdgeInsets.all(md16);
  static const EdgeInsets cardInnerPadding = EdgeInsets.all(cardPadding);

  // Gaps
  static const Gap gap4XS = Gap(xs8);
  static const Gap gap8SM = Gap(sm12);
  static const Gap gap16MD = Gap(md16);
  static const Gap gap24LG = Gap(lg24);
  static const Gap gap32XL = Gap(xl32);
  static const Gap gap48XXL = Gap(xxl40);

  // Custom gaps
  static Gap height(double height) => Gap(height);
  static Gap width(double width) => Gap(width);
}
