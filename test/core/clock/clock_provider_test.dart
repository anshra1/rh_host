// ignore_for_file: avoid_redundant_argument_values

// Package imports:
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rh_host/src/core/system/clock/app_time.dart';
import 'package:rh_host/src/core/system/clock/clock_provider.dart';
import 'package:rh_host/src/core/system/clock/time_config.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';

class MockDebugLogger extends Mock implements DebugLogger {}

void main() {
  late TimeProvider timeProvider;
  late TimeConfig config;
  late MockDebugLogger logger;

  setUp(() {
    logger = MockDebugLogger();
    DebugLogger.instance = logger;

    config = const TimeConfig();

    timeProvider = TimeProvider(config: config);
  });

  test('now() should return current time', () {
    withClock(Clock.fixed(DateTime(2024)), () {
      final now = timeProvider.now();
      expect(now.dateTime, DateTime(2024));
    });
  });

  group('isTimeValid', () {
    test('should return true for time within discrepancy limit', () {
      withClock(Clock.fixed(DateTime(2024)), () {
        final time = AppDateTime(
          dateTime: DateTime(2024).add(const Duration(minutes: 4)),
        );

        expect(timeProvider.isTimeValid(time), true);
        verifyNever(() => logger.warning(any<String>(), any<String>(), any()));
      });
    });

    test('should return false and log warning for time outside discrepancy limit', () {
      withClock(Clock.fixed(DateTime(2024)), () {
        final time = AppDateTime(
          dateTime: DateTime(2024).add(const Duration(minutes: 6)),
        );

        expect(timeProvider.isTimeValid(time), false);

        verify(
          () => logger.warning(
            'Time discrepancy detected',
            any<String>(),
            any(),
          ),
        ).called(1);
      });
    });
  });

  group('timeUntilNext', () {
    test('should calculate correct duration until next interval', () {
      withClock(Clock.fixed(DateTime(2024, 1, 1, 1, 30)), () {
        final result = timeProvider.timeUntilNext(
          const Duration(hours: 2),
          startFrom: AppDateTime(dateTime: DateTime(2024, 1, 1)),
        );

        expect(result, const Duration(minutes: 30));
      });
    });

    test('should use current time when startFrom is not provided', () {
      withClock(Clock.fixed(DateTime(2024, 1, 1, 1, 30)), () {
        final result = timeProvider.timeUntilNext(
          const Duration(hours: 1),
        );

        expect(result, const Duration(minutes: 30));
      });
    });
  });

  group('datetime operations', () {
    test('startOfDay should return midnight', () {
      final date = AppDateTime(
        dateTime: DateTime(2024, 1, 1, 12, 30),
      );

      final result = timeProvider.startOfDay(date);

      expect(result.dateTime.hour, 0);
      expect(result.dateTime.minute, 0);
      expect(result.dateTime.second, 0);
      expect(result.dateTime.millisecond, 0);
      expect(result.dateTime.microsecond, 0);
    });

    test('endOfDay should return last moment of day', () {
      final date = AppDateTime(
        dateTime: DateTime(2024, 1, 1, 12, 30),
      );

      final result = timeProvider.endOfDay(date);

      expect(result.dateTime.hour, 23);
      expect(result.dateTime.minute, 59);
      expect(result.dateTime.second, 59);
      expect(result.dateTime.millisecond, 999);
      expect(result.dateTime.microsecond, 999);
    });

    test('isSameDay should compare days correctly', () {
      final date1 = AppDateTime(dateTime: DateTime(2024, 1, 1, 12, 30));
      final date2 = AppDateTime(dateTime: DateTime(2024, 1, 1, 15, 45));
      final date3 = AppDateTime(dateTime: DateTime(2024, 1, 2, 12, 30));

      expect(timeProvider.isSameDay(date1, date2), true);
      expect(timeProvider.isSameDay(date1, date3), false);
    });
  });

  group('edge cases', () {
    test('should handle leap years correctly', () {
      final leapDay = AppDateTime(
        dateTime: DateTime(2024, 2, 29, 12, 30),
      );

      final nextDay = leapDay.add(const Duration(days: 1));

      expect(nextDay.dateTime.month, 3);
      expect(nextDay.dateTime.day, 1);
    });

    test('should handle daylight saving transitions', () {
      // This test demonstrates handling of DST transitions
      final beforeDST = AppDateTime(
        dateTime: DateTime(2024, 3, 10, 1, 59),
      );

      final afterDST = beforeDST.add(const Duration(minutes: 1));

      // Note: Actual behavior depends on the timezone settings
      // This test might need adjustment based on your timezone handling strategy
      expect(afterDST.dateTime.hour, isNot(beforeDST.dateTime.hour));
    });

    test('should handle year transitions', () {
      final newYearsEve = AppDateTime(
        dateTime: DateTime(2024, 12, 31, 23, 59),
      );

      final newYear = newYearsEve.add(const Duration(minutes: 1));

      expect(newYear.dateTime.year, 2025);
      expect(newYear.dateTime.month, 1);
      expect(newYear.dateTime.day, 1);
    });
  });

  group('performance tests', () {
    test('should handle rapid time calculations efficiently', () {
      final startTime = DateTime.now();

      for (var i = 0; i < 10000; i++) {
        timeProvider
          ..now()
          ..timeUntilNext(const Duration(hours: 1));
      }

      final duration = DateTime.now().difference(startTime);

      // Ensure operations complete within reasonable time
      // Adjust threshold based on your performance requirements
      expect(duration.inMilliseconds, lessThan(1000));
    });
  });
}
