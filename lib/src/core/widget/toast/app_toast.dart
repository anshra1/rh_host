import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/elevation.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/motion.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

enum AppToastType { info, success, warning, error }

class AppToast {
  static void show({
    required BuildContext context,
    required String message,
    AppToastType type = AppToastType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        message: message,
        type: type,
        onTap: onTap,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, overlayEntry.remove);
  }
}

class _ToastOverlay extends StatelessWidget {
  const _ToastOverlay({
    required this.message,
    required this.type,
    this.onTap,
  });

  final String message;
  final AppToastType type;
  final VoidCallback? onTap;

  Color get _backgroundColor {
    switch (type) {
      case AppToastType.info:
        return LightColorsToken.info;
      case AppToastType.success:
        return LightColorsToken.success;
      case AppToastType.warning:
        return LightColorsToken.warning;
      case AppToastType.error:
        return LightColorsToken.error;
    }
  }

  IconData get _icon {
    switch (type) {
      case AppToastType.info:
        return Icons.info_outline;
      case AppToastType.success:
        return Icons.check_circle_outline;
      case AppToastType.warning:
        return Icons.warning_amber_outlined;
      case AppToastType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Spacing.xl32,
      left: Spacing.md16,
      right: Spacing.md16,
      child: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: MotionTokens.durationMD,
          curve: MotionTokens.standardDecelerate,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: SafeArea(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppSize.radiusMD8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md16,
                  vertical: Spacing.sm12,
                ),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(AppSize.radiusMD8),
                  boxShadow: ElevationTokens.shadow2,
                ),
                child: Row(
                  children: [
                    Icon(
                      _icon,
                      color: LightColorsToken.textInverse,
                      size: AppSize.iconMD24,
                    ),
                    const SizedBox(width: Spacing.sm12),
                    Expanded(
                      child: Text(
                        message,
                        style: AppFonts.bodyMedium.copyWith(
                          color: LightColorsToken.textInverse,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
