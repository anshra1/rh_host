// import 'package:rh_host/src/core/enum/storage_codes.dart';
// import 'package:rh_host/src/core/storage/storage_context.dart';

// class StorageAnalytics {
//   const StorageAnalytics({
//     required this.errorCategory,
//     required this.severity,
//     required this.isRecoverable,
//     required this.shouldTrack,
//     this.customDimensions,
//   });

//   final StorageLogCategory errorCategory;
//   final ErrorSeverity severity;
//   final bool isRecoverable;
//   final bool shouldTrack;
//   final Map<String, dynamic>? customDimensions;
// }

// class SharedPrefErrorConfig {
//   static StorageAnalytics getAnalyticsInfo(
//     StorageErrorCode code, {
//     StorageErrorContext? context,
//   }) {
//     return StorageAnalytics(
//       errorCategory: getLogCategory(code),
//       severity: getSeverity(code),
//       isRecoverable: isRecoverable(code),
//       shouldTrack: code != StorageErrorCode.notFound, // Don't track expected errors
//       customDimensions: context?.additionalInfo,
//     );
//   }
// }