// ignore_for_file: avoid_print

import 'package:date_time/date_time.dart';

void main() {
  final dateTime = DateTime.now();
  final date = dateTime.date;
  final time = dateTime.time;

  print('Date is $date');
  print('Time is $time');

  // Compare dates
  final date2 = date.addDays(1);
  final isDate2After = date2 >= date;
  final isDate2After2 = date2.isAfter(date);
  print('Is date2 after: $isDate2After');

  // Compare times
  final time2 = time.addMinutes(30);
  final isTime2After = time2 > time;
  final isTime2After2 = time2.isAfter(time);
  print('Is time2 after: $isTime2After');

  // TimeRange crossing
  final timeRange = TimeRange(Time.now(), Time.now().addHours(6));
  final timeRange2 = TimeRange(Time.now().addHours(3), Time.now().addHours(9));

  final isCrossing = timeRange.isCross(timeRange2);
  print('Time ranges are crossing: $isCrossing');

  // String representation
  final Time? someTime = const Time(hour: 1, minute: 2, second: 3);
  print(someTime!.toStringWithSeparator('::'));

  // Get [Date] & [Time] from [DateTime]
  print(DateTime.now().date);
  print(DateTime.now().time);
}
