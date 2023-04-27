// ignore_for_file: constant_identifier_names, prefer_constructors_over_static_methods

import 'package:clock/clock.dart';
import 'package:date_time/date_time.dart';
import 'package:quiver/core.dart';

/// Format time
///
/// `HHmmssSSS` - 04:55:07:123
/// `HHmmss` - 04:55:07
/// `HHmm` - 04:55
/// `Hms` - 4:55:7
/// `Hm` - 4:55
enum TimeStringFormat {
  /// `HH:mm:ss:SSS` - 04:55:07:123
  HHmmssSSS,

  /// `HH:mm:ss` - 04:55:07
  HHmmss,

  /// `HH:mm` - 04:55
  HHmm,

  /// `H:m:s` - 4:5:7
  Hms,

  /// `H:m` - 4:5
  Hm,
}

enum TimeFormatType {
  hourFirst,

  millisecondLast,
}

/// Time object
///
/// `Time(11,30,45)` is 11:30:45
class Time {
  /// initialize `Time` object
  ///
  /// `Time(11,30,45)` for 11 hours 30 minutes 45 seconds
  const Time({
    required this.hour,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
  })  : assert(hour >= 0),
        assert(hour < 24),
        assert(minute >= 0),
        assert(minute <= 60),
        assert(second >= 0),
        assert(second <= 60),
        assert(millisecond >= 0),
        assert(millisecond <= 999);

  ///
  factory Time.from(DateTime dateTime) {
    return dateTime.time;
  }

  ///
  factory Time.fromMinutes(int amount) {
    return Time.fromSeconds(amount * 60);
  }

  ///
  factory Time.fromSeconds(int amount) {
    final isOverflowed = amount >= secondsInDay;
    if (isOverflowed) {
      final days = (amount / secondsInDay).floor();
      final secs = amount % secondsInDay;
      return Time.fromSeconds(secs).overflowBy(days);
    }

    const oneHourInSecs = 60 * 60;
    final h = (amount / oneHourInSecs).floor();
    final res = amount - (h * oneHourInSecs);

    final m = (res / 60).floor();
    final s = res % 60;
    return Time(hour: h, minute: m, second: s);
  }

  /// Convert to [DateTime]
  DateTime get asDateTime => DateTime.fromMillisecondsSinceEpoch(0).copyWith(
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
      );

  /// Convert to [DateTime] with the given [date]
  DateTime withDate(Date date) => date.asDateTime.copyWith(
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
      );

  /// Represents hours
  final int hour;

  /// Represents minutes
  final int minute;

  /// Represents seconds
  final int second;

  /// Represents the milliseconds `[0...999]`
  final int millisecond;

  /// Represents the `Time` in minutes or total minutes
  int get inMins => hour * 60 + minute;

  /// Represents the `Time` in seconds or total seconds
  int get inSeconds => inMins * 60 + second;

  /// Represents the `Time` in milliseconds or total milliseconds
  int get inMilliseconds => inSeconds * 1000 + millisecond;

  /// Represents the [Time] in [Duration]
  Duration get duration => Duration(milliseconds: inMilliseconds);

  /// Convert to `OverflowedTime` representation
  OverflowedTime get asOverflowed {
    if (this is OverflowedTime) {
      return this as OverflowedTime;
    }

    return OverflowedTime(hour: hour, days: 0, minute: minute, second: second);
  }

  /// Total minutes in a day
  static const minutesInDay = 24 * 60;

  /// Total seconds in a day
  static const secondsInDay = 24 * 60 * 60;

  /// Default separator
  static const defaultSeparator = ':';

  /// Tries to convert a string to `Time`
  ///
  /// [str] should be separated with `:`, eg: '23:30:21' or `3:17`
  static Time? fromStr(
    String? str, {
    String separator = ':',
    TimeFormatType formatType = TimeFormatType.hourFirst,
  }) {
    try {
      if (str == null || str.isEmpty) {
        return null;
      }

      final arr = str.split(separator);
      if (arr.isEmpty) {
        return null;
      }

      if (formatType == TimeFormatType.hourFirst) {
        final hour = int.parse(arr.first);
        final minute = int.parse(arr.length > 1 ? arr[1] : '0');
        final second = int.parse(arr.length > 2 ? arr[2] : '0');
        final ms = int.parse(arr.length > 3 ? arr[3] : '0');

        return Time(
          hour: hour,
          minute: minute,
          second: second,
          millisecond: ms,
        );
      } else {
        final reversed = arr.reversed.toList();
        final ms = int.parse(reversed[0]);
        final s = reversed.length > 1 ? int.parse(reversed[1]) : 0;
        final m = reversed.length > 2 ? int.parse(reversed[2]) : 0;
        final h = reversed.length > 3 ? int.parse(reversed[3]) : 0;
        return Time(hour: h, minute: m, second: s, millisecond: ms);
      }
    } catch (e) {
      return null;
    }
  }

  /// Add hours and may be `Overflowed`
  Time addHours(int amount) {
    return addDuration(Duration(hours: amount));
  }

  /// Add minutes and may be `Overflowed`
  Time addMinutes(int amount) {
    return addDuration(Duration(minutes: amount));
  }

  /// Add seconds and may be `Overflowed`
  Time addSeconds(int amount) {
    return addDuration(Duration(seconds: amount));
  }

  /// Now
  static Time now() {
    final dt = clock.now();
    return Time(
      hour: dt.hour,
      minute: dt.minute,
      second: dt.second,
    );
  }

  /// UTC Now
  static Time get utcNow {
    final dt = clock.now().toUtc();
    return Time(
      hour: dt.hour,
      minute: dt.minute,
      second: dt.second,
    );
  }

  /// Round the time to next nearest
  Time roundToTheNearestMin(int stepInMin, {bool back = false}) {
    final m = minute;
    final r = m % stepInMin;

    if (r == 0) {
      return this;
    }

    if (back) {
      // final delta = stepInMin - r;
      // final x = m + delta - stepInMin;
      return addMinutes(-r);
    }

    final delta = stepInMin - r;
    return addMinutes(delta);
  }

  /// Keep days
  OverflowedTime overflowBy(int days) {
    return OverflowedTime(
      hour: hour,
      days: days,
      minute: minute,
      second: second,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Time &&
      other.hour == hour &&
      other.minute == minute &&
      other.second == second;

  /// Format the `Time` to `String`
  String format([TimeStringFormat format = TimeStringFormat.HHmmssSSS]) {
    switch (format) {
      case TimeStringFormat.Hms:
        return [
          hour.toString(),
          minute.toString(),
          second.toString(),
        ].join(':');
      case TimeStringFormat.Hm:
        return [
          hour.toString(),
          minute.toString(),
        ].join(':');
      case TimeStringFormat.HHmm:
        return [
          hour.toString().padLeft(2, '0'),
          minute.toString().padLeft(2, '0'),
        ].join(':');
      case TimeStringFormat.HHmmss:
        return [
          hour.toString().padLeft(2, '0'),
          minute.toString().padLeft(2, '0'),
          second.toString().padLeft(2, '0'),
        ].join(':');
      case TimeStringFormat.HHmmssSSS:
        return [
          hour.toString().padLeft(2, '0'),
          minute.toString().padLeft(2, '0'),
          second.toString().padLeft(2, '0'),
          millisecond.toString().padLeft(3, '0'),
        ].join(':');
    }
  }

  /// Get the formatted `String` with the [separator] between each part
  String toStringWithSeparator(String separator) =>
      toString().replaceAll(Time.defaultSeparator, separator);

  ///////////////////////////////////// KEY

  /// Convert [Time] to a unique id (using dash, most db system won't accept : as id)
  String get key => format().replaceAll(':', '-');

  /// Convert a unique id to [Time]
  static Time? fromKey(String key) => fromStr(key.replaceAll('-', ':'));

  ///////////////////////////////////// COMPARISON

  /// Is the `Time` after another [time]
  bool isAfter(Time time, {bool orSame = false}) {
    return orSame ? this >= time : this > time;
  }

  /// Is the `Time` before another [time]
  bool isBefore(Time time, {bool orSame = false}) {
    return orSame ? this <= time : this < time;
  }

  /// Close to another [Time]
  ///
  /// [delta] The maximum seconds of which the two values may differ.
  /// Default delta is Duration(seconds: 1)
  bool closeTo(
    Time anotherTime, {
    Duration delta = const Duration(seconds: 1),
  }) {
    final anotherTimeTotalSeconds = anotherTime.inSeconds;
    final deltaSeconds = delta.inSeconds;

    var diff = anotherTimeTotalSeconds - inSeconds;
    if (diff < 0) {
      diff = -diff;
    }

    final isClose = diff <= deltaSeconds;
    return isClose;
  }

  bool operator >=(Time other) {
    return inMins >= other.inMins;
  }

  bool operator <=(Time other) {
    return inMins <= other.inMins;
  }

  bool operator <(Time other) {
    return inMins < other.inMins;
  }

  bool operator >(Time other) {
    return inMins > other.inMins;
  }

  Time operator +(Time other) {
    return Time.fromSeconds(inSeconds + other.inSeconds);
  }

  /// Comparator function used for sorting purpose
  int compareTo(Time other) => asDateTime.compareTo(other.asDateTime);

  /// Return true if time is within [start] and [end]
  bool isWithinRange(Time start, Time end) => this >= start && this <= end;

  ///////////////////////////////////// OPERATIONS

  Time addDuration(Duration dur) {
    final durationInSeconds = dur.inSeconds;
    return Time.fromSeconds(inSeconds + durationInSeconds);
  }

  Time operator -(Time other) {
    if (other.inSeconds >= inSeconds) {
      return const Time(hour: 0);
    }

    return Time.fromSeconds(inSeconds - other.inSeconds);
  }

  Time operator *(num times) {
    return Time.fromSeconds((inSeconds * times).ceil());
  }

  Time operator /(num times) {
    return Time.fromSeconds((inSeconds / times).floor());
  }

  @override
  int get hashCode => hash4(
        hour.hashCode,
        minute.hashCode,
        second.hashCode,
        millisecond.hashCode,
      );

  /// Represent the time as a `String` in the format `HH:mm:ss`
  @override
  String toString() => format();

  ///
  Time copyWith({int? hour, int? minute, int? second}) {
    return Time(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }

  /// Create a `Time` from milliseconds
  factory Time.fromMilliseconds(int totalMilliseconds) {
    final ms = totalMilliseconds % 1000;
    var seconds = (totalMilliseconds / 1000).floor();
    var minutes = (seconds / 60).floor();
    var hours = (minutes / 60).floor();

    seconds = seconds % 60;
    minutes = minutes % 60;

    // 👇️ If you don't want to roll hours over, e.g. 24 to 00
    // 👇️ comment (or remove) the line below
    // commenting next line gets you `24:00:00` instead of `00:00:00`
    // or `36:15:31` instead of `12:15:31`, etc.
    hours = hours % 24;

    return Time(hour: hours, minute: minutes, second: seconds, millisecond: ms);
  }

  /// Create a `Time` from duration
  factory Time.fromDuration(Duration duration) {
    return Time.fromMilliseconds(duration.inMilliseconds);
  }

  /// Represent the time as a `String` in the format `HH:mm:ss:SSS`
  String get title => toString();
}
