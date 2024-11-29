// import 'package:rh_host/src/core/error/exception/exception.dart';
// import 'package:rh_host/src/core/error/exception_formatter/stack_trace_parser.dart';

import 'package:flutter/foundation.dart';
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/exception/exception.dart';
import 'package:rh_host/src/core/error/exception_formatter/stack_trace_parser.dart';
import 'package:rh_host/src/core/logger/debug_logger.dart';

class ErrorFormatter {
  const ErrorFormatter._();
  static String getErrorSummary(AppException error, StackTrace stackTrace) {
    final trace = StackTraceParser.formatStackTrace(stackTrace);

    return '''
Type: ${error.runtimeType}
Code: ${error.errorCode}
Message: ${error.showUImessage}
Details: ${error.debugDetails ?? 'None'}
Location: ${trace.split('\n').first}
''';
  }

  static String getDetailedError(AppException error, StackTrace stackTrace) {
    final formattedStack = StackTraceParser.formatStackTrace(stackTrace);
    final timestamp = DateTime.now().toIso8601String();

    return '''
----------------------------------------
Time: $timestamp
Method: ${error.methodName}
Type: ${error.runtimeType}
Code: ${error.errorCode}
Severity: ${error.severity}
Is Recoverable: ${error.isRecoverable}
Message: ${error.showUImessage}
Technical Details: ${error.debugDetails ?? 'None'}
Debug Code: ${error.debugCode}
Stack:
$formattedStack
----------------------------------------
''';
  }

  // For production logging/analytics
  static Map<String, dynamic> toJson(AppException error, StackTrace stackTrace) {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'method': error.methodName,
      'type': error.runtimeType.toString(),
      'error_code': error.errorCode.toString(),
      'severity': error.severity.toString(),
      'is_recoverable': error.isRecoverable,
      'message': error.showUImessage,
      'debug_code': error.debugCode,
      'details': error.debugDetails,
      'location': StackTraceParser.formatStackTrace(stackTrace).split('\n').first,
    };
  }

  // Main entry point for error formatting
  static String format(
    dynamic error,
    StackTrace stackTrace, {
    String? methodName,
    String? additionalContext,
  }) {
    if (error is AppException) {
      return _formatAppException(error, stackTrace);
    }
    return _formatGenericError(error, stackTrace, methodName, additionalContext);
  }

  static String _formatAppException(AppException error, StackTrace stackTrace) {
    final timestamp = DateTime.now().toIso8601String();
    final rootCause = _findRootCause(stackTrace);
    final attemptInfo = _getAttemptInfo(error.methodName);
    final impactPath = _findImpactPath(stackTrace);
    final potentialFixes = _getPotentialFixes(error, rootCause);

    return '''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TIMESTAMP: $timestamp

ROOT CAUSE:
$rootCause

EXCEPTION INFO:
  Type: ${error.runtimeType}
  Category: ${error.category}
  Error Code: ${error.errorCode}
  Debug Code: ${error.debugCode}
  Severity: ${error.severity}
  Method: ${error.methodName} $attemptInfo
  Is Recoverable: ${error.isRecoverable}

MESSAGES:
  User Message: ${error.showUImessage}
  Technical Details: ${error.debugDetails ?? 'No details provided'}

IMPACT (Affected Components):
$impactPath

SUGGESTED FIXES:
$potentialFixes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━''';
  }

  static String _formatGenericError(
    dynamic error,
    StackTrace stackTrace,
    String? methodName,
    String? additionalContext,
  ) {
    final timestamp = DateTime.now().toIso8601String();
    final rootCause = _findRootCause(stackTrace);
    final impactPath = _findImpactPath(stackTrace);

    return '''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TIMESTAMP: $timestamp

ROOT CAUSE:
$rootCause

ERROR INFO:
  Type: ${error.runtimeType}
  Message: $error
  Method: ${methodName ?? 'Unknown'}
  ${additionalContext != null ? 'Context: $additionalContext' : ''}

IMPACT (Affected Components):
$impactPath

SUGGESTED FIXES:
${_getGenericFixes(error, rootCause)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━''';
  }

  static String _findRootCause(StackTrace stackTrace) {
    final lines = stackTrace.toString().split('\n');

    const ignorePaths = [
      'exception_thrower.dart',
      'error_handler.dart',
      'dart:async',
      'package:test_api',
      'package:flutter',
    ];

    for (final line in lines) {
      if (ignorePaths.any(line.contains)) {
        continue;
      }

      if (line.contains('package:') || line.contains('/lib/')) {
        final match = RegExp(r'#\d+\s+(.+)\s+\((.+):(\d+):(\d+)\)').firstMatch(line);
        if (match != null) {
          final method = match.group(1)?.trim();
          final file = match.group(2)?.split('/').last;
          final lineNo = match.group(3);
          final column = match.group(4);

          return '''
  Method: $method
  File: $file
  Line: $lineNo
  Column: $column
  Full Path: ${match.group(2)}''';
        }
        return line;
      }
    }
    return 'Could not determine root cause';
  }

  static String _findImpactPath(StackTrace stackTrace) {
    final lines = stackTrace.toString().split('\n');
    final impactedPaths = <String>[];

    const ignorePaths = [
      'dart:async',
      'package:test_api',
      'package:flutter',
    ];

    for (final line in lines) {
      if (ignorePaths.any(line.contains)) {
        continue;
      }

      if (line.contains('package:') || line.contains('/lib/')) {
        final match = RegExp(r'#\d+\s+(.+)\s+\((.+)\)').firstMatch(line);
        if (match != null) {
          final method = match.group(1)?.trim();
          final location = match.group(2)?.split('/').last.replaceAll('.dart', '');
          impactedPaths.add('  → $method in $location');
        }
      }
    }

    return impactedPaths.isEmpty
        ? '  No impact path available'
        : impactedPaths.take(5).join('\n');
  }

  static String _getPotentialFixes(AppException error, String rootCause) {
    final fixes = <String>[];

    // Add category-specific fixes
    switch (error.category) {
      case ErrorCategory.storage:
        fixes.addAll(_getStorageFixes(error, rootCause));
      case ErrorCategory.network:
        fixes.addAll(_getNetworkFixes(error));
      case ErrorCategory.auth:
        fixes.addAll(_getAuthFixes(error));
      // ignore: no_default_cases
      default:
        fixes.addAll(_getGenericFixes(error, rootCause));
    }

    // Add severity-based recommendations
    if (error.severity == ErrorSeverity.high || error.severity == ErrorSeverity.fatal) {
      fixes.add('• Consider implementing error boundary or fallback mechanism');
    }

    return fixes.isEmpty
        ? '  No specific fixes available - review error details'
        : fixes.join('\n');
  }

  static List<String> _getStorageFixes(AppException error, String rootCause) {
    final fixes = <String>[];

    if (rootCause.contains('Mock')) {
      fixes.addAll([
        '• Fix Mock Implementation:',
        '    when(() => mock.methodName()).thenAnswer(...)',
        '• Verify mock setup in tests',
      ]);
    }

    if (error.debugCode.toString().contains('disk')) {
      fixes.addAll([
        '• Check available storage space',
        '• Implement data cleanup mechanism',
        '• Consider data compression',
      ]);
    }

    return fixes;
  }

  static List<String> _getNetworkFixes(AppException error) {
    return [
      '• Check network connectivity',
      '• Verify API endpoint availability',
      '• Implement retry mechanism',
      '• Add timeout handling',
    ];
  }

  static List<String> _getAuthFixes(AppException error) {
    return [
      '• Verify user authentication state',
      '• Check token validity',
      '• Implement auto-refresh token',
      '• Add re-authentication flow',
    ];
  }

  static List<String> _getGenericFixes(dynamic error, String rootCause) {
    return [
      '• Review error handling in affected components',
      '• Add error logging and monitoring',
      '• Implement proper error recovery',
      '• Consider adding unit tests',
    ];
  }

  static String _getAttemptInfo(String methodName) {
    final attemptMatch = RegExp(r'Attempt (\d+) of (\d+)').firstMatch(methodName);
    if (attemptMatch != null) {
      return '(Attempt ${attemptMatch.group(1)} of ${attemptMatch.group(2)})';
    }
    return '';
  }
}

// Usage:
void logError(dynamic error, StackTrace stackTrace, [String? methodName]) {
  final formattedError = ErrorFormatter.format(
    error,
    stackTrace,
    methodName: methodName,
  );

  // Log to console in development
  debugPrint(formattedError);

  // Log to analytics in production
  DebugLogger.instance.error(formattedError, error, stackTrace);
}
