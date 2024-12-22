import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.title,
    required this.content,
    this.actions,
    super.key,
  });

  final String title;
  final Widget content;
  final List<Widget>? actions;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightColorsToken.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.radiusLG16),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DragHandle(),
            Padding(
              padding: const EdgeInsets.all(Spacing.md16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: AppFonts.headlineSmall,
                  ),
                  const SizedBox(height: Spacing.md16),
                  content,
                  if (actions != null) ...[
                    const SizedBox(height: Spacing.md16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Spacing.sm12),
        width: 32.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: LightColorsToken.neutral400,
          borderRadius: BorderRadius.circular(AppSize.radiusCircle),
        ),
      ),
    );
  }
}
