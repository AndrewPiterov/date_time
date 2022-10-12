// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'package:date_time/date_time.dart';

void main() {
  final dateTime = DateTime.now();
  final date = dateTime.date;
  final time = dateTime.time;

  final time2 = Time(hour: 6, minute: 30, second: 7);
  print(time2);
  print(time2.copyWith(second: 0));
}
