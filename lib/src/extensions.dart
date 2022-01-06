import 'date.dart';
import 'time.dart';

/// Extensions on [DateTime]
extension DateTimeExtensions on DateTime {
  /// Create a [Date] instance from a [DateTime].
  Date get date => Date(year, month, day);

  /// Create a [Time] instance from a [DateTime].
  Time get time => Time(hour, mins: minute, secs: second);
}
