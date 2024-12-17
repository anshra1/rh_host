part of 'import.dart';

class AppEdgeInsets {
  static const EdgeInsets zero = EdgeInsets.zero;

  static const EdgeInsets xxxSmall = EdgeInsets.all(2);
  static const EdgeInsets xxSmall = EdgeInsets.all(4);
  static const EdgeInsets xSmall = EdgeInsets.all(6);
  static const EdgeInsets small = EdgeInsets.all(8);
  static const EdgeInsets medium = EdgeInsets.all(12);
  static const EdgeInsets large = EdgeInsets.all(16);
  static const EdgeInsets xLarge = EdgeInsets.all(20);
  static const EdgeInsets xxLarge = EdgeInsets.all(24);
  static const EdgeInsets xxxLarge = EdgeInsets.all(32);

  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets horizontalLarge = EdgeInsets.symmetric(horizontal: 16);

  static const EdgeInsets verticalSmall = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets verticalLarge = EdgeInsets.symmetric(vertical: 16);

  static const EdgeInsets onlyTopSmall = EdgeInsets.only(top: 8);
  static const EdgeInsets onlyTopMedium = EdgeInsets.only(top: 12);
  static const EdgeInsets onlyTopLarge = EdgeInsets.only(top: 16);

  // Add more EdgeInsets presets as needed
}