// status_screen_content.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rh_host/src/core/design_system/base/app_font.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/enum/button_enum.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/themes/status_theme.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';
import 'package:rh_host/src/core/widget/buttons/import.dart';
import 'package:rh_host/src/core/widget/conditional/conditional_content.dart';
import 'package:rh_host/src/core/widget/scaffold/base_scaffold.dart';
import 'package:rh_host/src/core/widget/text/text.dart';

class StatusScreenContent extends StatelessWidget {
  const StatusScreenContent({required this.config, super.key});

  final StatusScreenModel config;

  @override
  Widget build(BuildContext context) {
    DebugLogger.instance.info(context.textSecondary);
    DebugLogger.instance.info(context.textPrimary);
    return BaseScaffold(
      padding: const EdgeInsets.all(16),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatusIcon(),
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

  Widget _buildStatusIcon() {
    final theme = statusThemes[config.type]!;

    if (theme.animationAsset != null) {
      return Lottie.asset(
        theme.animationAsset!,
        width: 120,
        height: 120,
      );
    }

    return Icon(
      theme.icon,
      size: 80,
      color: theme.color,
    );
  }
}

class StatusActionsWidget extends StatelessWidget {
  const StatusActionsWidget({
    required this.config,
    super.key,
  });

  final StatusScreenModel config;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          onPressed: () {
            if (config.nextRouteParams != null) {
              context.pushReplacementNamed(
                config.nextRoute,
                extra: config.nextRouteParams,
              );
            } else {
              context.pushReplacementNamed(config.nextRoute);
            }
          },
          label: config.primaryButtonText,
        ),
        ConditionalContent(
          show: config.secondaryButtonText != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacing.gap16MD,
              OutlineButton(
                onPressed: () => context.pop(),
                text: config.secondaryButtonText!,
              ),
            ],
          ),
        ),
        ConditionalContent(
          show: config.additionalActions != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacing.gap16MD,
              ...config.additionalActions!.map((action) {
                return BaseButton(
                  variant: ButtonVariant.secondary,
                  onPressed: () => action.onPressed(),
                  text: action.label,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

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
