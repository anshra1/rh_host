import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_time.freezed.dart';

@freezed
class AppDateTime with _$AppDateTime {
  const factory AppDateTime({
    required DateTime dateTime,
  }) = _AppDateTime;

  const AppDateTime._();

  /// Creates an instance with current time
  factory AppDateTime.now() => AppDateTime(dateTime: clock.now());

  /// Creates an instance from UTC milliseconds
  factory AppDateTime.fromMilliseconds(int milliseconds) =>
      AppDateTime(dateTime: DateTime.fromMillisecondsSinceEpoch(milliseconds));

  /// Creates an instance from UTC microseconds
  factory AppDateTime.fromMicroseconds(int microseconds) => AppDateTime(
        dateTime: DateTime.fromMicrosecondsSinceEpoch(microseconds, isUtc: true),
      );

  /// Creates an instance from ISO8601 string
  factory AppDateTime.fromIso8601String(String date) =>
      AppDateTime(dateTime: DateTime.parse(date));

  // UTC conversions
  bool get isUtc => dateTime.isUtc;
  DateTime get toLocal => dateTime.toLocal();
  DateTime get toUtc => dateTime.toUtc();

  // Timestamps
  int get millisecondsSinceEpoch => dateTime.millisecondsSinceEpoch;
  int get microsecondsSinceEpoch => dateTime.microsecondsSinceEpoch;
  String get iso8601 => dateTime.toIso8601String();

  // State checks
  bool get isToday {
    final now = clock.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  bool get isPast => dateTime.isBefore(clock.now());
  bool get isFuture => dateTime.isAfter(clock.now());

  // Comparisons
  Duration difference(AppDateTime other) => dateTime.difference(other.dateTime);
  bool isBefore(AppDateTime other) => dateTime.isBefore(other.dateTime);
  bool isAfter(AppDateTime other) => dateTime.isAfter(other.dateTime);
  bool isAtSameMomentAs(AppDateTime other) => dateTime.isAtSameMomentAs(other.dateTime);

  AppDateTime copyWithed({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return AppDateTime(
      dateTime: DateTime(
        year ?? dateTime.year,
        month ?? dateTime.month,
        day ?? dateTime.day,
        hour ?? dateTime.hour,
        minute ?? dateTime.minute,
        second ?? dateTime.second,
        millisecond ?? dateTime.millisecond,
        microsecond ?? dateTime.microsecond,
      ),
    );
  }

  // Operations
  AppDateTime add(Duration duration) => AppDateTime(dateTime: dateTime.add(duration));

  AppDateTime subtract(Duration duration) =>
      AppDateTime(dateTime: dateTime.subtract(duration));
}
