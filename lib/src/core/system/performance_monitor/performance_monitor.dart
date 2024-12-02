// import 'package:firebase_performance/firebase_performance.dart';
// import 'package:flutter/foundation.dart';
// import 'package:synchronized/synchronized.dart';

// class PerformanceMonitor {
//   PerformanceMonitor({
//     required FirebasePerformance performance,
//   }) : _performance = performance {
//     _initialize();
//   }

//   final FirebasePerformance _performance;
//   final _activeTraces = <String, Trace>{};
//   final _lock = Lock();
//   final _metrics = <String, List<double>>{};
  
//   Future<void> _initialize() async {
//     await _performance.setPerformanceCollectionEnabled(!kDebugMode);
//   }

//   Future<void> startTrace(String name) async {
//     await _lock.synchronized(() async {
//       if (_activeTraces.containsKey(name)) return;
      
//       final trace = _performance.newTrace(name);
//       await trace.start();
//       _activeTraces[name] = trace;
//     });
//   }

//   Future<void> stopTrace(String name) async {
//     await _lock.synchronized(() async {
//       final trace = _activeTraces.remove(name);
//       if (trace != null) {
//         await trace.stop();
//       }
//     });
//   }

//   Future<void> addMetric(String name, double value) async {
//     await _lock.synchronized(() async {
//       _metrics.putIfAbsent(name, () => []).add(value);
      
//       // Calculate and record average if we have enough data
//       if (_metrics[name]!.length >= 10) {
//         final average = _metrics[name]!.reduce((a, b) => a + b) / _metrics[name]!.length;
//         for (final trace in _activeTraces.values) {
//           trace.setMetric(name, average.toInt());
//         }
//         _metrics[name]!.clear();
//       }
//     });
//   }

//   Future<void> recordNetworkRequest({
//     required String url,
//     required HttpMethod method,
//     required int responseCode,
//     required int requestSize,
//     required int responseSize,
//     String? contentType,
//   }) async {
//     final metric = _performance.newHttpMetric(url, method);
    
//     await metric.start();
//     try {
//       metric..httpResponseCode = responseCode
//       ..requestPayloadSize = requestSize
//       ..responsePayloadSize = responseSize;
//       if (contentType != null) {
//         metric.responseContentType = contentType;
//       }
//     } finally {
//       await metric.stop();
//     }
//   }

//   void dispose() {
//     _activeTraces.clear();
//     _metrics.clear();
//   }
// }

// enum HttpMethod {
//   connect,
//   delete,
//   get,
//   head,
//   options,
//   patch,
//   post,
//   put,
//   trace
// }