// status_screen_simple.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/presentation/shared_status_screen_widget.dart';

class StatusScreenSimple extends HookWidget {
  const StatusScreenSimple({required this.config, super.key});

  final StatusScreenModel config;

  static const routeName = '/status-screen-simple';

  @override
  Widget build(BuildContext context) {
    // useEffect(() {
    //   //    StatusAnalytics.logStatusScreenView(config);
    //   return null;
    // }, []);

    return StatusScreenContent(config: config);
  }
}
