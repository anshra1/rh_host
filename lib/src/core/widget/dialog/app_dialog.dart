import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/design_system/base/size.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
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
    return showDialog<T>(
      context: context,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: AppFonts.headlineSmall,
      ),
      content: content,
      actions: actions,
      titlePadding: const EdgeInsets.only(
        left: Spacing.md16,
        right: Spacing.md16,
        top: Spacing.md16,
      ),
      contentPadding: const EdgeInsets.all(Spacing.md16),
      actionsPadding: const EdgeInsets.all(Spacing.sm12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusLG16),
      ),
    );
  }
}
