// // ignore_for_file: unused_field, avoid_dynamic_calls

// // Dart imports:
// import 'dart:async';

// // Package imports:
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_performance/firebase_performance.dart';
// // Flutter imports:
// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:synchronized/synchronized.dart';

// class ProductionErrorHandler {
//   ProductionErrorHandler({
//     required FirebaseCrashlytics crashlytics,
//     required FirebaseAnalytics analytics,
//     required FirebasePerformance performance,
//     required FlutterSecureStorage secureStorage,
//   })  : _crashlytics = crashlytics,
//         _analytics = analytics,
//         _performance = performance,
//         _secureStorage = secureStorage {
//     _initialize();
//   }

//   final FirebaseCrashlytics _crashlytics;
//   final FirebaseAnalytics _analytics;
//   final FirebasePerformance _performance;
//   final FlutterSecureStorage _secureStorage;

//   final _errorQueue = StreamController<ErrorEvent>.broadcast();
//   final _lock = Lock();
//   final Map<String, String> _userProperties = {};
//   bool _initialized = false;

//   static const _maxQueueSize = 100;
//   static const _processingInterval = Duration(seconds: 1);

//   Future<void> _initialize() async {
//     if (_initialized) return;

//     await _lock.synchronized(() async {
//       if (_initialized) return;

//       // Initialize crash reporting
//       await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

//       // Set up app info
//       final packageInfo = await PackageInfo.fromPlatform();
//       await _crashlytics.setCustomKey('app_version', packageInfo.version);
//       await _crashlytics.setCustomKey('build_number', packageInfo.buildNumber);

//       // Start processing error queue
//       _startErrorProcessing();

//       _initialized = true;
//     });
//   }

//   Future<void> setUserContext(String userId, {Map<String, String>? properties}) async {
//     await _crashlytics.setUserIdentifier(userId);
//     await _analytics.setUserId(id: userId);

//     if (properties != null) {
//       _userProperties.addAll(properties);
//       for (final entry in properties.entries) {
//         await _crashlytics.setCustomKey(entry.key, entry.value);
//         await _analytics.setUserProperty(name: entry.key, value: entry.value);
//       }
//     }
//   }

//   Future<void> handleError(
//     dynamic error,
//     StackTrace stackTrace, {
//     required String context,
//     Map<String, dynamic>? additionalData,
//     bool fatal = false,
//     ErrorPriority priority = ErrorPriority.normal,
//   }) async {
//     try {
//       final event = ErrorEvent(
//         error: error,
//         stackTrace: stackTrace,
//         context: context,
//         additionalData: additionalData,
//         fatal: fatal,
//         priority: priority,
//         timestamp: DateTime.now(),
//       );

//       // Queue the error for processing
//       _errorQueue.add(event);

//       // Handle fatal errors immediately
//       if (fatal) {
//         await _processError(event);
//       }
//     } catch (e, s) {
//       debugPrint('Error in error handler: $e\n$s');
//       // Last resort error reporting
//       await _crashlytics.recordError(e, s,
//           reason: 'Error handler failure',
//           fatal: true,
//           information: ['Original error: $error'],);
//     }
//   }

//   void _startErrorProcessing() {
//     Timer.periodic(_processingInterval, (_) async {
//       await _processErrors();
//     });
//   }

//   Future<void> _processErrors() async {
//     if (!_initialized) return;

//     await _lock.synchronized(() async {
//       try {
//         final errors = await _errorQueue.stream.take(_maxQueueSize).toList();
//         for (final error in errors) {
//           await _processError(error);
//         }
//       } catch (e, s) {
//         debugPrint('Error processing queue: $e\n$s');
//       }
//     });
//   }

//   Future<void> _processError(ErrorEvent event) async {
//     try {
//       // Sanitize and enrich error data
//       final enrichedData = await _enrichErrorData(event.additionalData);

//       // Record performance trace
//       final trace = _performance.newTrace('error_processing');
//       await trace.start();

//       try {
//         // Process in isolate for heavy operations
//         if (event.priority == ErrorPriority.high) {
//           await compute(_processErrorInIsolate, event);
//         }

//         // Record to Crashlytics
//         await _recordToCrashlytics(event, enrichedData);

//         // Log to Analytics
//         await _logToAnalytics(event, enrichedData);
//       } finally {
//         await trace.stop();
//       }
//     } catch (e, s) {
//       debugPrint('Error processing error event: $e\n$s');
//       await _crashlytics.recordError(e, s,
//           reason: 'Error processing failure',
//           information: ['Original context: ${event.context}'],);
//     }
//   }

//   Future<void> _recordToCrashlytics(
//     ErrorEvent event,
//     Map<String, dynamic> enrichedData,
//   ) async {
//     final keys = enrichedData.entries.map((e) => '${e.key}: ${e.value}').toList();

//     await _crashlytics.recordError(
//       event.error,
//       event.stackTrace,
//       reason: event.context,
//       fatal: event.fatal,
//       information: [
//         'Context: ${event.context}',
//         'Priority: ${event.priority}',
//         'Timestamp: ${event.timestamp}',
//         ...keys,
//       ],
//     );
//   }

//   Future<void> _logToAnalytics(
//     ErrorEvent event,
//     Map<String, dynamic> enrichedData,
//   ) async {
//     await _analytics.logEvent(
//       name: 'error_occurred',
//       parameters: {
//         'error_context': event.context,
//         'error_type': event.error.runtimeType.toString(),
//         'fatal': event.fatal,
//         'priority': event.priority.toString(),
//         ...enrichedData,
//       },
//     );
//   }

//   Future<Map<String, dynamic>> _enrichErrorData(
//     Map<String, dynamic>? additionalData,
//   ) async {
//     final packageInfo = await PackageInfo.fromPlatform();

//     return {
//       ...?additionalData,
//       'app_version': packageInfo.version,
//       'build_number': packageInfo.buildNumber,
//       'user_properties': _userProperties,
//       'timestamp': DateTime.now().toIso8601String(),
//     };
//   }

//   void dispose() {
//     _errorQueue.close();
//   }
// }

// enum ErrorPriority { low, normal, high }

// class ErrorEvent {
//   ErrorEvent({
//     required this.error,
//     required this.stackTrace,
//     required this.context,
//     this.additionalData,
//     this.fatal = false,
//     this.priority = ErrorPriority.normal,
//     DateTime? timestamp,
//   }) : timestamp = timestamp ?? DateTime.now();

//   final dynamic error;
//   final StackTrace stackTrace;
//   final String context;
//   final Map<String, dynamic>? additionalData;
//   final bool fatal;
//   final ErrorPriority priority;
//   final DateTime timestamp;
// }

// Future<void> _processErrorInIsolate(ErrorEvent event) async {
//   // Implement any heavy processing here
//   // This runs in a separate isolate
//   await Future<void>.delayed(const Duration(milliseconds: 100)); // Simulate work
// }
