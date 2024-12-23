// lottie_assets.dart
// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/material.dart';
import 'package:rh_host/src/core/gen/assets.gen.dart';

class LottieAsset {
  const LottieAsset._({
    required this.lightAnimationPath,
    required this.darkAnimationPath,
    required this.fallbackIcon,
    required this.lightColor,
    required this.darkColor,
  });

  // Factory methods for each asset type
  static LottieAsset success() => LottieAsset._(
        lightAnimationPath: Assets.animations.light.success.path,
        darkAnimationPath: Assets.animations.light.success.path,
        fallbackIcon: Icons.check_circle_outline,
        lightColor: const Color(0xFF43A047),
        darkColor: const Color(0xFF81C784),
      );

  static LottieAsset error() => LottieAsset._(
        lightAnimationPath: Assets.animations.light.success.path,
        darkAnimationPath: Assets.animations.light.success.path,
        fallbackIcon: Icons.error_outline,
        lightColor: const Color(0xFFE53935),
        darkColor: const Color(0xFFEF5350),
      );

  static LottieAsset warning() => LottieAsset._(
        lightAnimationPath: Assets.animations.light.success.path,
        darkAnimationPath: Assets.animations.light.success.path,
        fallbackIcon: Icons.warning_outlined,
        lightColor: const Color(0xFFFB8C00),
        darkColor: const Color(0xFFFFB74D),
      );

  static LottieAsset info() => LottieAsset._(
        lightAnimationPath: Assets.animations.light.success.path,
        darkAnimationPath: Assets.animations.light.success.path,
        fallbackIcon: Icons.info_outline,
        lightColor: const Color(0xFF1976D2),
        darkColor: const Color(0xFF64B5F6),
      );

  static LottieAsset loading() => LottieAsset._(
        lightAnimationPath: Assets.animations.light.success.path,
        darkAnimationPath: Assets.animations.light.success.path,
        fallbackIcon: Icons.hourglass_empty,
        lightColor: const Color(0xFF1E88E5),
        darkColor: const Color(0xFF64B5F6),
      );

  final String lightAnimationPath;
  final String darkAnimationPath;
  final IconData fallbackIcon;
  final Color lightColor;
  final Color darkColor;
}

