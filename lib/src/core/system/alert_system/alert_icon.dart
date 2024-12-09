// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/system/alert_system/alert.dart';
import 'package:rh_host/src/core/system/alert_system/alert_utils.dart';

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
