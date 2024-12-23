import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/asset/lotte_assets.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/presentation/widgets/status_actions.dart';
import 'package:rh_host/src/core/page/status/presentation/widgets/status_custom_content.dart';
import 'package:rh_host/src/core/page/status/themes/status_icon_theme.dart';
import 'package:rh_host/src/core/widget/scaffold/base_scaffold.dart';
import 'package:rh_host/src/core/widget/text/text.dart';

class StatusScreenContent extends StatelessWidget {
  const StatusScreenContent({required this.config, super.key});
  final StatusScreenModel config;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      padding: const EdgeInsets.all(16),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusIcon(config.type),
                Spacing.gap8SM,
                AppText(
                  style: AppFonts.headlineLarge.medium,
                  config.title,
                  color: context.textPrimary,
                ),
                Spacing.gap4XS,
                AppText.bodyLarge(
                  config.message,
                  color: context.textSecondary,
                ),
                CustomContentWidget(config: config),
              ],
            ),
          ),
          StatusActionsWidget(config: config),
          Spacing.gap24LG,
        ],
      ),
    );
  }

  Widget _buildStatusIcon(StatusType type) {
    switch (type) {
      case StatusType.success:
        return const LottieAsset(asset: LottieAssets.success);
      case StatusType.error:
        return const LottieAsset(asset: LottieAssets.error);
      case StatusType.warning:
        return const LottieAsset(asset: LottieAssets.warning);
      case StatusType.loading:
        return const LottieAsset(asset: LottieAssets.loading);
      case StatusType.info:
        return const LottieAsset(asset: LottieAssets.info);
    }
  }
}
