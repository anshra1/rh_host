import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/page/alert_system/alert_action.dart';

class Alert extends Equatable {
  const Alert({
    required this.message,
    required this.type,
    this.title,
    this.action,
    this.duration = const Duration(seconds: 3),
    this.dismissible = true,
  });

  final String message;
  final String? title;
  final AlertType type;
  final AlertAction? action;
  final Duration duration;
  final bool dismissible;

  @override
  List<Object?> get props =>
      [message, title, type, action, duration, dismissible];
}
