import 'date.dart';
import 'time.dart';

/// Extensions on [DateTime]
extension DateTimeExtensions on DateTime {
  /// Create a [Date] instance from a [DateTime].
  Date get date => Date(year: year, month: month, day: day);

  /// Create a [Time] instance from a [DateTime].
  Time get time => Time(hour: hour, minute: minute, second: second);
}
