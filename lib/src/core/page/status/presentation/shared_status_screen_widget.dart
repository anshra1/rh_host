// status_screen_content.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/widget/buttons/import.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/themes/status_theme.dart';
import 'package:rh_host/src/core/widget/conditional/conditional_content.dart';
import 'package:rh_host/src/core/widget/text/text.dart';

class StatusScreenContent extends StatelessWidget {
  const StatusScreenContent({required this.config, super.key});

  final StatusScreenModel config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (config.showCloseButton)
                //   Align(
                //     alignment: Alignment.topRight,
                //     child: IconButton(
                //       icon: const Icon(Icons.close),
                //       onPressed: () {
                //         // StatusAnalytics.logStatusAction('close_button', config);
                //         context.pop();
                //       },
                //     ),
                //   ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatusIcon(),
                      Spacing.gapSM,
                      AppText.headlineMedium(config.title),
                      Spacing.gapXS,
                      AppText.displayLarge(config.message),
                      ConditionalContent(
                        show: config.customContent != null,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Spacing.gapLG,
                            config.customContent!,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                _buildActions(context),
                Spacing.gapLG,
              ],
            ),
          ),
        ),
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

  Widget _buildActions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          onPressed: () {
            //  StatusAnalytics.logStatusAction('primary_button', config);
            _handleNavigation(context);
          },
          label: config.primaryButtonText,
        ),
        if (config.secondaryButtonText != null) ...[
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              //  StatusAnalytics.logStatusAction('secondary_button', config);
              context.pop();
            },
            child: Text(config.secondaryButtonText!),
          ),
        ],
        if (config.additionalActions != null) ...[
          const SizedBox(height: 16),
          ..._buildAdditionalActions(context),
        ],
      ],
    );
  }

  List<Widget> _buildAdditionalActions(BuildContext context) {
    return config.additionalActions!.map((action) {
      return TextButton(
        onPressed: () {
          // StatusAnalytics.logStatusAction('additional_action', config);
          action.onPressed();
        },
        style: TextButton.styleFrom(
          foregroundColor: action.textColor,
          backgroundColor: action.backgroundColor,
        ),
        child: Text(action.label),
      );
    }).toList();
  }

  void _handleNavigation(BuildContext context) {
    if (config.nextRouteParams != null) {
      context.pushReplacementNamed(
        config.nextRoute,
        extra: config.nextRouteParams,
      );
    } else {
      context.pushReplacementNamed(config.nextRoute);
    }
  }
}
