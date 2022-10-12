// ignore_for_file: avoid_print

import 'package:clock/clock.dart';
import 'package:date_time/date_time.dart';

void main() {
  withClock(
    Clock(
      () => DateTime.now().subtract(const Duration(days: 10, minutes: 214)),
    ),
    () {
      print(clock.now()); // 2022-06-21 16:28:46.366887
      print(DateTime.now()); // 2022-07-01 20:02:46.367579
      print('${Date.now()} ${Time.now()}'); // 6/21/2022 16:28:46
    },
  );
}
