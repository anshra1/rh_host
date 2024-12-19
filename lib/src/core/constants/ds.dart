// Flutter imports:
import 'package:flutter/widgets.dart';

/// Core design system constants and metrics
abstract class DS {
  const DS._();

  /// Component measurements and dimensions
  static const sizes = _Sizes._();

  /// Spacing and layout measurements
  static const layout = _Layout._();

  /// Border radius and shapes
  static const radius = _Radius._();
}

class _Sizes {
  const _Sizes._();

  // Icons
  double get iconXSmall => 12;
  double get iconSmall => 16;
  double get iconMedium => 24;
  double get iconLarge => 32;

  // Touch targets
  double get minTouch => 48;
  double get smallTouch => 40;

  // Buttons
  double get buttonSmall => 32;
  double get buttonMedium => 40;
  double get buttonLarge => 48;

  // Common components
  double get appBar => 56;
  double get bottomNav => 80;
  double get fab => 56;
}

class _Layout {
  const _Layout._();

  // Base 4pt grid system
  double get xs => 4;
  double get sm => 8;
  double get md => 16;
  double get lg => 24;
  double get xl => 32;

  // Common layout spacing
  double get gutter => md;
  double get section => xl;

  // Screen padding
  EdgeInsets get screenPadding => EdgeInsets.all(md);
  EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: md,
        vertical: sm,
      );
}

class _Radius {
  const _Radius._();

  double get sm => 4;
  double get md => 8;
  double get lg => 16;
  double get full => 999;

  // Component specific
  double get button => md;
  double get card => lg;
  double get dialog => lg;
}

// Usage:
// Container(
//   height: DS.sizes.buttonMedium,
//   padding: DS.layout.buttonPadding,
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(DS.radius.button),
//   ),
// );
