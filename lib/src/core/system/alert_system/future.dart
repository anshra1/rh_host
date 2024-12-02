// class AlertRateLimiter {
//   final _alertHistory = <DateTime>[];
//   final Duration threshold;
  
//   bool shouldShowAlert() {
//     final now = DateTime.now();
//     _alertHistory.removeWhere(
//       (time) => now.difference(time) > threshold,
//     );
//     return _alertHistory.length < maxAlertsPerMinute;
//   }
// }