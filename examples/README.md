
# Examples

```dart
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
}
```
