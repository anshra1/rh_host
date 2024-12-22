import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';

class ErrorDetails {
  ErrorDetails({
    required this.originalError,
    required this.message,
    required this.category,
    required this.severity,
    this.context,
    this.additionalData,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  // Factory method for dynamic errors
  factory ErrorDetails.fromDynamic(
    dynamic error,
    String? context,
    Map<String, dynamic>? additionalData,
  ) {
    if (error is Error) {
      return ErrorDetails(
        originalError: error,
        message: error.toString(),
        category: ErrorCategory.unknown,
        severity: ErrorSeverity.high,
        context: context,
        additionalData: {
          ...?additionalData,
          'stackTrace': error.stackTrace?.toString(),
        },
      );
    }
    return ErrorDetails(
      originalError: error,
      message: error.toString(),
      category: ErrorCategory.unknown,
      severity: ErrorSeverity.medium,
      context: context,
      additionalData: additionalData,
    );
  }

  // Factory method for AppException
  factory ErrorDetails.fromException(
    AppException error,
    String? context,
    Map<String, dynamic>? additionalData,
  ) {
    return ErrorDetails(
      originalError: error,
      message: error.showUImessage ?? 'Unknown error',
      category: error.category,
      severity: error.severity,
      context: context,
      additionalData: {
        ...?additionalData,
        'code': error.debugCode,
        'details': error.debugDetails,
        'isRecoverable': error.isRecoverable,
        if (error.dartStackTrace != null)
          'errorStackTrace': error.dartStackTrace.toString(),
      },
    );
  }

  final dynamic originalError;
  final String message;
  final ErrorCategory category;
  final ErrorSeverity severity;
  final String? context;
  final Map<String, dynamic>? additionalData;
  final DateTime timestamp;

  ErrorDetails copyWith({
    dynamic originalError,
    String? message,
    ErrorCategory? category,
    ErrorSeverity? severity,
    String? context,
    Map<String, dynamic>? additionalData,
    DateTime? timestamp,
  }) {
    return ErrorDetails(
      originalError: originalError ?? this.originalError,
      message: message ?? this.message,
      category: category ?? this.category,
      severity: severity ?? this.severity,
      context: context ?? this.context,
      additionalData: additionalData ?? this.additionalData,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'category': category.toString(),
        'severity': severity.toString(),
        'context': context,
        'timestamp': timestamp.toIso8601String(),
        'additionalData': additionalData,
      };
}
