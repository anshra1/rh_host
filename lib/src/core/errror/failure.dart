import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/enum/%20error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/errror/error_codes.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.code,
    this.category = ErrorCategory.unknown,
    this.severity = ErrorSeverity.low,
    this.isRecoverable,
  });

  final String message;
  final ErrorCode code;
  final ErrorCategory category;
  final ErrorSeverity severity;
  final bool? isRecoverable;

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.code,
    super.category,
    super.isRecoverable,
    super.severity,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.code,
    super.category,
    super.isRecoverable,
    super.severity,
  });
}

class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    required super.code,
    super.category,
    super.isRecoverable,
    super.severity,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    required super.code,
    super.category,
    super.isRecoverable,
    super.severity,
  });
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    required super.code,
    super.category,
    super.isRecoverable,
    super.severity,
  });

  @override
  List<Object?> get props => [...super.props];
}
