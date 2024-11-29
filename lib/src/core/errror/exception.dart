// ignore_for_file: use_super_parameters

import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/enum/%20error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({
    required this.code,
    required this.message,
    this.details,
    this.stackTrace,
    this.severity = ErrorSeverity.low,
    this.category = ErrorCategory.unknown,
    this.isRecoverable,
  });

  final dynamic code;
  final String? message;
  final String? details;
  final StackTrace? stackTrace;
  final ErrorSeverity severity;
  final ErrorCategory category;
  final bool? isRecoverable;

  @override
  List<Object?> get props => [
        code,
        message,
        details,
        stackTrace,
        severity,
        category,
        isRecoverable,
      ];

  @override
  String toString() {
    return '''
  AppException:
  Category: ${category.name}
  Severity: ${severity.name}
  Code: $code
  Message: $message
  Details: $details
  Recoverable: $isRecoverable
  StackTrace: $stackTrace
''';
  }

  Map<String, dynamic> toMap() => {
        'category': category.name,
        'severity': severity.name,
        'code': code,
        'message': message,
        'details': details,
        'isRecoverable': isRecoverable,
        'timestamp': DateTime.now().toIso8601String(),
      };
}

class ServerException extends AppException {
  const ServerException({
    required dynamic code,
    String? message,
    ErrorCategory errorCategory = ErrorCategory.unknown,
    String? details,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          code: code,
          message: message,
          details: details,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class CacheException extends AppException {
  const CacheException({
    required String code,
    required String message,
    ErrorCategory errorCategory = ErrorCategory.sharedPreferences,
    String? details,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          code: code,
          message: message,
          details: details,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class NetworkException extends AppException {
  const NetworkException({
    required String code,
    required String message,
    String? details,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          code: code,
          message: message,
          details: details,
          stackTrace: stackTrace,
          severity: severity,
          category: ErrorCategory.network,
          isRecoverable: isRecoverable,
        );
}

class NetworkTimeOutException extends AppException {
  const NetworkTimeOutException({
    required String code,
    required String message,
    ErrorCategory errorCategory = ErrorCategory.network,
    String? details,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          code: code,
          message: message,
          details: details,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class ValidationException extends AppException {
  const ValidationException({
    required String code,
    required String message,
    ErrorCategory errorCategory = ErrorCategory.validation,
    String? details,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          code: code,
          message: message,
          details: details,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}
