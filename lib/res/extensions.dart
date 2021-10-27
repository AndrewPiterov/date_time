import 'package:date_time/res/date.dart';
import 'package:date_time/res/time.dart';

extension DateTimeExtensions on DateTime {
  Date get date => Date(year, month, day);
  Time get time => Time(hour, mins: minute, secs: second);
}
