import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/core/design_system/base/import.dart';
import 'package:rh_host/src/core/enum/button_enum.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/widget/buttons/import.dart';
import 'package:rh_host/src/core/widget/conditional/conditional_content.dart';

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

