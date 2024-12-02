import 'package:flutter/material.dart';
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/system/alert_system/alert.dart';

class AlertUtils {
  static IconData getIcon(Alert alert) {
    return switch (alert.type) {
      AlertType.info => Icons.info_outline,
      AlertType.success => Icons.check_circle_outline,
      AlertType.warning => Icons.warning_amber_rounded,
      AlertType.error => Icons.error_outline,
    };
  }

  static Color getColor(Alert alert) {
    return switch (alert.type) {
      AlertType.info => Colors.blue.shade700,
      AlertType.success => Colors.green.shade700,
      AlertType.warning => Colors.orange.shade700,
      AlertType.error => Colors.red.shade700,
    };
  }
}
