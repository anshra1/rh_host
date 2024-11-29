// enum ErrorSeverity {
//   low, // Non-critical errors
//   medium, // Important but not critical
//   high, // Critical errors
//   fatal, // App-breaking errors
// }

// enum ErrorCategory {
//   authentication,
//   firestoreClient,
//   firebaseStorage,
//   sharedPreferences,
//   network,
//   validation,
//   businessLogic,
//   unknown,
// }

// abstract class AppException implements Exception {
//   const AppException({
//     required this.code,
//     required this.message,
//     this.details,
//     this.stackTrace,
//     this.severity = ErrorSeverity.low,
//     this.category = ErrorCategory.unknown,
//     this.isRecoverable,
//   });

//   final String code;
//   final String message;
//   final String? details;
//   final StackTrace? stackTrace;
//   final ErrorSeverity severity;
//   final ErrorCategory category;
//   final bool? isRecoverable;

//   @override
//   String toString() {
//     return '''
//   AppException:
//   Category: ${category.name}
//   Severity: ${severity.name}
//   Code: $code
//   Message: $message
//   Details: $details
//   Recoverable: $isRecoverable
//   StackTrace: $stackTrace
// ''';
//   }

//   Map<String, dynamic> toMap() => {
//         'category': category.name,
//         'severity': severity.name,
//         'code': code,
//         'message': message,
//         'details': details,
//         'isRecoverable': isRecoverable,
//         'timestamp': DateTime.now().toIso8601String(),
//       };
// }
