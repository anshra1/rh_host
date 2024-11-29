
class TimeConfig {
  const TimeConfig({
    this.maxTimeDiscrepancy = const Duration(minutes: 5),
    this.timeZone = 'UTC',
  });

  final Duration maxTimeDiscrepancy;
  final String timeZone;
}
