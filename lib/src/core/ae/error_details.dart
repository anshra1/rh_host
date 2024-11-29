// import 'package:rh_host/src/core/ae/b.dart';
// import 'package:rh_host/src/core/error/exception.dart';

// class ErrorDetails {

//   ErrorDetails({
//     required this.originalError,
//     required this.message,
//     required this.severity,
//     required this.category,
//     required this.isRecoverable,
//     this.context,
//     this.metadata,
//   });
//   factory ErrorDetails.fromDynamic(
//     dynamic error,
//     String? context,
//     Map<String, dynamic>? additionalData,
//   ) {
//     return ErrorDetails(
//       originalError: error,
//       message: error.toString(),
//       severity: ErrorSeverity.medium,
//       category: ErrorCategory.unknown,
//       isRecoverable: true,
//       context: context,
//       metadata: additionalData,
//     );
//   }

//   factory ErrorDetails.fromException(
//     AppException exception,
//     String? context,
//     Map<String, dynamic>? additionalData,
//   ) {
//     return ErrorDetails(
//       originalError: exception,
//       message: exception.message,
//       severity: exception.severity,
//       category: exception.category,
//       isRecoverable: exception.isRecoverable,
//       context: context,
//       metadata: {
//         ...?exception.context,
//         ...?additionalData,
//       },
//     );
//   }
//   final dynamic originalError;
//   final String message;
//   final ErrorSeverity severity;
//   final ErrorCategory category;
//   final bool isRecoverable;
//   final String? context;
//   final Map<String, dynamic>? metadata;

//   Map<String, dynamic> toMap() => {
//         'message': message,
//         'severity': severity.name,
//         'category': category.name,
//         'isRecoverable': isRecoverable,
//         'context': context,
//         ...?metadata,
//       };
// }
