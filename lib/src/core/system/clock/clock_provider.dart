import 'package:rh_host/src/core/system/clock/app_time.dart';
import 'package:rh_host/src/core/system/clock/time_config.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';

class TimeProvider {
  const TimeProvider({
    required TimeConfig config,
  }) : _config = config;

  final TimeConfig _config;

  AppDateTime now() => AppDateTime.now();

  DateTime get currentTime => AppDateTime.now().dateTime;

  bool isTimeValid(AppDateTime time) {
    final now = AppDateTime.now();
    final difference = now.difference(time).abs();

    if (difference > _config.maxTimeDiscrepancy) {
      DebugLogger.instance.warning(
        'Time discrepancy detected',
        'Time difference of $difference exceeds maximum allowed ${_config.maxTimeDiscrepancy}\n'
            'systemTime: ${now.iso8601}\n'
            'providedTime ${time.iso8601}\n'
            'difference_ms ${difference.inMilliseconds}\n',
      );
      return false;
    }
    return true;
  }

  Duration timeUntilNext(Duration interval, {AppDateTime? startFrom}) {
    final now = AppDateTime.now();
    final start = startFrom ?? now;
    final timeSinceStart = now.difference(start);
    final intervals = (timeSinceStart.inMicroseconds / interval.inMicroseconds).ceil();
    final nextInterval = start.dateTime.add(interval * intervals);
    return nextInterval.difference(now.dateTime);
  }

  //  Duration difference(AppDateTime other) => dateTime.difference(other.dateTime);

  /// Returns start of day (00:00:00) for given DateTime
  AppDateTime startOfDay(AppDateTime date) => date.copyWithed(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );

  /// Returns end of day (23:59:59.999999) for given DateTime
  AppDateTime endOfDay(AppDateTime date) => date.copyWithed(
        hour: 23,
        minute: 59,
        second: 59,
        millisecond: 999,
        microsecond: 999,
      );

  /// Returns true if both dates are on same day
  bool isSameDay(AppDateTime date1, AppDateTime date2) {
    return date1.dateTime.year == date2.dateTime.year &&
        date1.dateTime.month == date2.dateTime.month &&
        date1.dateTime.day == date2.dateTime.day;
  }
}
