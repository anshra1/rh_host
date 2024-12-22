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
  static const pageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  // Common animation presets - these need to stay as getters since they create new instances
  static const fadeIn = AnimationConfig(
    curve: standardDecelerate,
    duration: durationMD,
  );

  static const fadeOut = AnimationConfig(
    curve: standardAccelerate,
    duration: durationSM,
  );

  static const slideIn = AnimationConfig(
    curve: emphasizedDecelerate,
    duration: durationMD,
  );

  static const slideOut = AnimationConfig(
    curve: emphasizedAccelerate,
    duration: durationSM,
  );
}

/// Configuration class for animations
class AnimationConfig {
  const AnimationConfig({
    required this.curve,
    required this.duration,
  });

  final Curve curve;
  final Duration duration;

  AnimationConfig copyWith({
    Curve? curve,
    Duration? duration,
  }) {
    return AnimationConfig(
      curve: curve ?? this.curve,
      duration: duration ?? this.duration,
    );
  }
}
