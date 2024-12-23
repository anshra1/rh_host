// lottie_assets.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum LottieAssets {
  success(
    lightAnimationPath: 'assets/animations/light/success.json',
    darkAnimationPath: 'assets/animations/light/success.json',
    fallbackIcon: Icons.check_circle_outline,
    lightColor: Color(0xFF43A047),
    darkColor: Color(0xFF81C784),
  ),

  error(
    lightAnimationPath: 'assets/animations/light/error.json',
    darkAnimationPath: 'assets/animations/dark/error.json',
    fallbackIcon: Icons.error_outline,
    lightColor: Color(0xFFE53935),
    darkColor: Color(0xFFEF5350),
  ),

  warning(
    lightAnimationPath: 'assets/animations/light/warning.json',
    darkAnimationPath: 'assets/animations/dark/warning.json',
    fallbackIcon: Icons.warning_outlined,
    lightColor: Color(0xFFFB8C00),
    darkColor: Color(0xFFFFB74D),
  ),
  info(
    lightAnimationPath: 'assets/animations/light/warning.json',
    darkAnimationPath: 'assets/animations/dark/warning.json',
    fallbackIcon: Icons.warning_outlined,
    lightColor: Color(0xFFFB8C00),
    darkColor: Color(0xFFFFB74D),
  ),

  loading(
    lightAnimationPath: 'assets/animations/light/loading.json',
    darkAnimationPath: 'assets/animations/dark/loading.json',
    fallbackIcon: Icons.hourglass_empty,
    lightColor: Color(0xFF1E88E5),
    darkColor: Color(0xFF64B5F6),
  );

  const LottieAssets({
    required this.lightAnimationPath,
    required this.darkAnimationPath,
    required this.fallbackIcon,
    required this.lightColor,
    required this.darkColor,
  });

  final String lightAnimationPath;
  final String darkAnimationPath;
  final IconData fallbackIcon;
  final Color lightColor;
  final Color darkColor;
}

class LottieAsset extends StatelessWidget {
  const LottieAsset({
    required this.asset,
    this.width = 120,
    this.height = 120,
    this.repeat = true,
    this.animate = true,
    this.fit = BoxFit.contain,
    super.key,
  });

  final LottieAssets asset;
  final double width;
  final double height;
  final bool repeat;
  final bool animate;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final animationPath = brightness == Brightness.light
        ? asset.lightAnimationPath
        : asset.darkAnimationPath;
    final iconColor = brightness == Brightness.light ? asset.lightColor : asset.darkColor;

    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
      fit: fit,
      repeat: repeat,
      animate: animate,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Lottie error for $animationPath: $error');
        return Icon(
          asset.fallbackIcon,
          size: width * 0.67,
          color: iconColor,
        );
      },
      frameBuilder: (context, child, composition) {
        if (composition == null) {
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: CircularProgressIndicator(
                color: iconColor,
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
