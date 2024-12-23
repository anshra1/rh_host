import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rh_host/src/core/design_system/asset/lotte_assets.dart';

class LottieAssetViewer extends StatelessWidget {
  const LottieAssetViewer({
    required this.asset,
    this.width = 120,
    this.height = 120,
    this.repeat = true,
    this.animate = true,
    this.fit = BoxFit.contain,
    super.key,
  });

  final LottieAsset asset;
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
