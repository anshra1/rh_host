import 'package:flutter/material.dart';
import 'package:rh_host/src/core/page/alert_system/alert.dart';
import 'package:rh_host/src/core/page/alert_system/alert_utils.dart';

class AlertIcon extends StatelessWidget {
  const AlertIcon({
    required this.alert,
    super.key,
  });

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Icon(
      AlertUtils.getIcon(alert),
      color: AlertUtils.getColor(alert),
    );
  }
}
