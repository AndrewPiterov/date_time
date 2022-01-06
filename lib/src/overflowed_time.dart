import 'time.dart';

/// To keep days
class OverflowedTime extends Time {
  /// Initialize new `OverflowedTime` instance
  const OverflowedTime({
    required int hours,
    required this.days,
    int min = 0,
    int sec = 0,
  }) : super(hours, mins: min, secs: sec);

  /// Days
  final int days;

  @override
  int get inMins => (days * 24 * 60) + (hours * 60) + mins;
}
