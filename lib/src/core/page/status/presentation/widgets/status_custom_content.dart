import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/widget/conditional/conditional_content.dart';

class CustomContentWidget extends StatelessWidget {
  const CustomContentWidget({
    required this.config,
    super.key,
  });

  final StatusScreenModel config;

  @override
  Widget build(BuildContext context) {
    return ConditionalContent(
      show: config.customContent != null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacing.gap24LG,
          config.customContent ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
