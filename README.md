# date_time

Package to work with Date & Time in separation and with its ranges.

This project will be useful for projects that are related to booking.

## Features

* Only Date comparison
* Only Time comparison
* Find crossing of dates
* Find crossing of times in the day

## Getting started

1. Add dependency

```yml
dependencies:
  date_time: <newest>
```

2. Import the dependency

```dart
import 'package:date_time/date_time.dart';
```

## Usage

Please, check ([examples](./example/dates.dart)) folder for more advanced examples.

### Date

```dart
given('DateTime', () {
  final dateTime = DateTime(2020, 11, 30, 14, 33, 17);

  then('date should be equal to', () {
    dateTime.date.should.be(Date(2020, 11, 30));
  });

  then('time should be equal to', () {
    dateTime.time.should.be(Time(14, mins: 33, secs: 17));
  });
});
```

### DateRange

```dart
final range = DateRange(
  const Date(2021, 1, 1),
  const Date(2021, 12, 31),
);

test('should be valid', () {
  range.isValid.should.beTrue();
});
```

### Time

```dart
final time2 = time.addMinutes(30);
final isTime2After = time2 > time;
final isTime2After2 = time2.isAfter(time);
print('Is time2 after: $isTime2After');
```

### Overflowed Time

to keep days

```dart
final time = Time(20).addHours(5);

print(time is OverflowedTime); // prints `true`
print(time.asOverflowed.days); // prints `1`

```

### TimeRange

```dart
// TimeRange crossing
final timeRange = TimeRange(Time.now, Time.now.addHours(6));
final timeRange2 = TimeRange(Time.now.addHours(3), Time.now.addHours(9));

final isCrossing = timeRange.isCross(timeRange2);
print('Time ranges are crossing: $isCrossing');
```

## Contributing

We accept the following contributions:

* New features
* Improving documentation
* Reporting issues
* Fixing bugs

## Maintainers

* [Andrew Piterov](mailto:piterov1990@gmail.com?subject=[GitHub]%20Source%20Dart%20date_time)
