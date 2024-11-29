// ignore_for_file: use_super_parameters

import 'package:equatable/equatable.dart';
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({
    required this.debugCode,
    required this.errorCode,
    required this.showUImessage,
    required this.methodName,
    this.debugDetails,
    this.stackTrace,
    this.severity = ErrorSeverity.low,
    this.category = ErrorCategory.unknown,
    this.isRecoverable,
    this.dartError,
  });

  final dynamic debugCode;
  final ErrorCode errorCode;
  final String? showUImessage;
  final String? debugDetails;
  final StackTrace? stackTrace;
  final ErrorSeverity severity;
  final ErrorCategory category;
  final bool? isRecoverable;
  final String methodName;
  final dynamic dartError;

  @override
  List<Object?> get props => [
        debugCode,
        showUImessage,
        debugDetails,
        stackTrace,
        severity,
        category,
        isRecoverable,
        methodName,
        dartError,
      ];

  @override
  String toString() {
    final timestamp = DateTime.now().toIso8601String();
    final formattedStack = stackTrace != null ? stackTrace! : 'No stack trace available';

    return '''
----------------------------------------
Time: $timestamp
Method: $methodName
Code: $errorCode
Category: ${category.name}
Severity: ${severity.name}
Is Recoverable: ${isRecoverable ?? 'Unknown'}
Message: ${showUImessage ?? 'No message provided'}
Technical Details: ${debugDetails ?? 'None'}
Debug Code: $debugCode
Dart Error: $dartError
Stack Trace:
$formattedStack
----------------------------------------
''';
  }

  /// Creates a map representation of the exception
  Map<String, dynamic> toJson() => {
        'timestamp': DateTime.now().toIso8601String(),
        'methodName': methodName,
        'errorCode': errorCode.toString(),
        'category': category.name,
        'severity': severity.name,
        'isRecoverable': isRecoverable,
        'message': showUImessage,
        'debugDetails': debugDetails,
        'debugCode': debugCode.toString(),
        'stackTrace': stackTrace?.toString(),
      };
}

class ServerException extends AppException {
  const ServerException({
    required ErrorCode errorCode,
    required dynamic debugCode,
    required String methodName,
    String? showUImessage,
    ErrorCategory errorCategory = ErrorCategory.unknown,
    String? debugDetails,
    StackTrace? dartStackTrace,
    ErrorSeverity severity = ErrorSeverity.low,
    bool? isRecoverable,
  }) : super(
          debugCode: debugCode,
          methodName: methodName,
          errorCode: errorCode,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: dartStackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class CacheException extends AppException {
  const CacheException({
    required ErrorCode errorCode,
    required String debugCode,
    required String showUImessage,
    required String methodName,
    ErrorCategory errorCategory = ErrorCategory.sharedPreferences,
    String? debugDetails,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          debugCode: debugCode,
          methodName: methodName,
          errorCode: errorCode,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class StorageException extends AppException {
  const StorageException({
    required super.errorCode,
    required String super.debugCode,
    required String super.showUImessage,
    required super.methodName,
    ErrorCategory errorCategory = ErrorCategory.sharedPreferences,
    super.debugDetails,
    super.stackTrace,
    super.severity = ErrorSeverity.medium,
    super.isRecoverable,
  }) : super(
          category: errorCategory,
        );
}

class NetworkException extends AppException {
  const NetworkException({
    required ErrorCode errorCode,
    required String debugCode,
    required String showUImessage,
    required String methodName,
    String? debugDetails,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          errorCode: errorCode,
          debugCode: debugCode,
          methodName: methodName,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: stackTrace,
          severity: severity,
          category: ErrorCategory.network,
          isRecoverable: isRecoverable,
        );
}

class NetworkTimeOutException extends AppException {
  const NetworkTimeOutException({
    required ErrorCode errorCode,
    required String debugCode,
    required String showUImessage,
    required String methodName,
    ErrorCategory errorCategory = ErrorCategory.network,
    String? debugDetails,
    StackTrace? stackTrace,
    ErrorSeverity severity = ErrorSeverity.medium,
    bool? isRecoverable,
  }) : super(
          errorCode: errorCode,
          debugCode: debugCode,
          methodName: methodName,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: stackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class ValidationException extends AppException {
  const ValidationException({
    required dynamic debugCode,
    required String methodName,
    required ErrorCode errorCode,
    String? showUImessage,
    ErrorCategory errorCategory = ErrorCategory.unknown,
    String? debugDetails,
    StackTrace? dartStackTrace,
    ErrorSeverity severity = ErrorSeverity.low,
    bool? isRecoverable,
  }) : super(
          debugCode: debugCode,
          methodName: methodName,
          errorCode: errorCode,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: dartStackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}

class UnknownException extends AppException {
  const UnknownException({
    required ErrorCode errorCode,
    required dynamic debugCode,
    required String methodName,
    String? showUImessage,
    ErrorCategory errorCategory = ErrorCategory.unknown,
    String? debugDetails,
    StackTrace? dartStackTrace,
    ErrorSeverity severity = ErrorSeverity.low,
    bool? isRecoverable,
  }) : super(
          debugCode: debugCode,
          methodName: methodName,
          errorCode: errorCode,
          showUImessage: showUImessage,
          debugDetails: debugDetails,
          stackTrace: dartStackTrace,
          severity: severity,
          category: errorCategory,
          isRecoverable: isRecoverable,
        );
}
