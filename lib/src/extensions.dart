import 'package:date_time/src/date.dart';
import 'package:date_time/src/time.dart';
import 'package:intl/intl.dart';

/// Extensions on [DateTime]
extension DateTimeExtensions on DateTime {
  /// Create a [Date] instance from a [DateTime].
  Date get date => Date(year: year, month: month, day: day);

  /// Create a [Time] instance from a [DateTime].
  Time get time => Time(hour: hour, minute: minute, second: second);
}

/// Extensions on [DateFormat]
extension DateFormatExtensions on DateFormat {
  /// Format a [Date] instance.
  String formatDate(Date date) {
    return format(date.asDateTime);
  }
}
