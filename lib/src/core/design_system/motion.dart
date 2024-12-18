import 'package:flutter/material.dart';

abstract class MotionTokens {
  // Durations
  static const Duration durationXS = Duration(milliseconds: 100);
  static const Duration durationSM = Duration(milliseconds: 200);
  static const Duration durationMD = Duration(milliseconds: 300);
  static const Duration durationLG = Duration(milliseconds: 400);
  static const Duration durationXL = Duration(milliseconds: 500);

  // Curves
  static const Curve standard = Curves.easeInOut;
  static const Curve standardAccelerate = Curves.easeIn;
  static const Curve standardDecelerate = Curves.easeOut;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve emphasizedAccelerate = Curves.easeInCubic;
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;

  // Page transitions
  static PageTransitionsTheme get pageTransitions => const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      );

  // Common animation presets
  static AnimationConfig get fadeIn => const AnimationConfig(
        curve: standardDecelerate,
        duration: durationMD,
      );

  static AnimationConfig get fadeOut => const AnimationConfig(
        curve: standardAccelerate,
        duration: durationSM,
      );

  static AnimationConfig get slideIn => const AnimationConfig(
        curve: emphasizedDecelerate,
        duration: durationMD,
      );

  static AnimationConfig get slideOut => const AnimationConfig(
        curve: emphasizedAccelerate,
        duration: durationSM,
      );
}

// New class for animation configuration
class AnimationConfig {
  const AnimationConfig({
    required this.curve,
    required this.duration,
  });

  final Curve curve;
  final Duration duration;
}
