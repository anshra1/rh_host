// Dart imports:
import 'dart:async';

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/presentation/widgets/status_screen_content.dart';

class StatusScreenWithTimer extends HookWidget {
  const StatusScreenWithTimer({required this.config, super.key});

  final StatusScreenModel config;
  static const String routeName = '/status-screen-with-timer';

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        if (config.autoNavigateAfter == null) return null;

        final timer = Timer(config.autoNavigateAfter!, () {
          if (config.nextRouteParams != null) {
            context.pushNamed(config.nextRoute, extra: config.nextRouteParams);
          } else {
            context.go(config.nextRoute);
          }
        });

        return timer.cancel;
      },
      [],
    );

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: StatusScreenContent(config: config),
    );
  }
}
