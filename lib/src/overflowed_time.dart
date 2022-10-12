import 'package:date_time/date_time.dart';

/// To keep days
class OverflowedTime extends Time {
  /// Initialize new `OverflowedTime` instance
  const OverflowedTime({
    required int hour,
    required this.days,
    int minute = 0,
    int second = 0,
  }) : super(hour: hour, minute: minute, second: second);

  /// Days
  final int days;

  @override
  int get inMins => (days * 24 * 60) + (hour * 60) + minute;
}
