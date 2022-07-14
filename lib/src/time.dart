// ignore_for_file: constant_identifier_names, prefer_constructors_over_static_methods

import 'package:clock/clock.dart';
import 'package:date_time/date_time.dart';
import 'package:quiver/core.dart';

import 'overflowed_time.dart';

/// Format time
///
/// `HHmmss` - 04:55:07
/// `HHmm` - 04:55
/// `Hms` - 4:55:7
/// `Hm` - 4:55
enum TimeStringFormat {
  ///
  HHmmss,

  ///
  HHmm,

  ///
  Hms,

  ///
  Hm,
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
  })  : assert(hour >= 0),
        assert(hour < 24),
        assert(minute >= 0),
        assert(minute <= 60),
        assert(second >= 0),
        assert(second <= 60);

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
    final isOveflowed = amount >= secondsInDay;
    if (isOveflowed) {
      final days = (amount / secondsInDay).floor();
      final secs = amount % secondsInDay;
      return Time.fromSeconds(secs).oveflowBy(days);
    }

    const oneHourInSecs = 60 * 60;
    final h = (amount / oneHourInSecs).floor();
    final res = amount - (h * oneHourInSecs);

    final m = (res / 60).floor();
    final s = res % 60;
    return Time(hour: h, minute: m, second: s);
  }

  /// Represents hours
  final int hour;

  /// Represents minutes
  final int minute;

  /// Represents seconds
  final int second;

  /// Represents the `Time` in minutes
  int get inMins => hour * 60 + minute;

  /// Represents the `Time` in seconds
  int get inSeconds => inMins * 60 + second;

  /// Convert to `OverflowedTime` representation
  OverflowedTime get asOverflowed {
    if (this is OverflowedTime) {
      return this as OverflowedTime;
    }

    return OverflowedTime(hour: hour, days: 0, minute: minute, second: second);
  }

  ///
  static const minutesInDay = 24 * 60;

  ///
  static const secondsInDay = 24 * 60 * 60;

  ///
  static const defaultSeparator = ':';

  /// Tries to onvert a string to `Time`
  ///
  /// [str] should be separated with `:`, eg: '23:30:21' or `3:17`
  static Time? fromStr(String? str, {String separator = ':'}) {
    try {
      if (str == null || str.isEmpty) {
        return null;
      }

      final arr = str.split(separator);
      if (arr.isEmpty) {
        return null;
      }

      final hour = int.parse(arr.first);
      final minute = int.parse(arr.length > 1 ? arr[1] : '0');
      final second = int.parse(arr.length > 2 ? arr[2] : '0');

      return Time(hour: hour, minute: minute, second: second);
    } catch (e) {
      return null;
    }
  }

  /// Add hours and may be `Oveflowed`
  Time addHours(int amount) {
    return addDuration(Duration(hours: amount));
  }

  /// Add minutes and may be `Oveflowed`
  Time addMinutes(int amount) {
    return addDuration(Duration(minutes: amount));
  }

  /// Add seconds and may be `Oveflowed`
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
  OverflowedTime oveflowBy(int days) {
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

  /// Allowed formats `HH:mm:ss` and `HH:mm`
  String format([String format = 'HH:mm:ss']) {
    if (format == 'HH:mm:ss') {
      // ignore: avoid_redundant_argument_values
      return formatAs(TimeStringFormat.HHmmss);
    }

    if (format == 'HH:mm') {
      return formatAs(TimeStringFormat.HHmm);
    }

    return toString();
  }

  /// Allowed formats `HH:mm:ss` and `HH:mm`
  String formatAs([TimeStringFormat format = TimeStringFormat.HHmmss]) {
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
      default:
        return toString();
    }
  }

  ///
  String toStringWithSeparator(String separator) =>
      toString().replaceAll(Time.defaultSeparator, separator);

  ///
  bool isAfter(Time time, {bool orSame = false}) {
    return orSame ? this >= time : this > time;
  }

  ///
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

  // @override
  ///
  bool operator >=(Time other) {
    return inMins >= other.inMins;
  }

  // @override
  ///
  bool operator <=(Time other) {
    return inMins <= other.inMins;
  }

  ///
  bool operator <(Time other) {
    return inMins < other.inMins;
  }

  ///
  bool operator >(Time other) {
    return inMins > other.inMins;
  }

  ///
  Time operator +(Time other) {
    return Time.fromSeconds(inSeconds + other.inSeconds);
  }

  ///
  Time addDuration(Duration dur) {
    final durationInSeconds = dur.inSeconds;
    return Time.fromSeconds(inSeconds + durationInSeconds);
  }

  ///
  Time operator -(Time other) {
    if (other.inSeconds >= inSeconds) {
      return const Time(hour: 0);
    }

    return Time.fromSeconds(inSeconds - other.inSeconds);
  }

  ///
  Time operator *(num times) {
    return Time.fromSeconds((inSeconds * times).ceil());
  }

  ///
  Time operator /(num times) {
    return Time.fromSeconds((inSeconds / times).floor());
  }

  @override
  int get hashCode => hash3(
        hour.hashCode,
        minute.hashCode,
        second.hashCode,
      );

  @override
  String toString() => [
        hour.toString().padLeft(2, '0'),
        minute.toString().padLeft(2, '0'),
        second.toString().padLeft(2, '0'),
      ].join(defaultSeparator);

  ///
  Time copyWith({int? hour, int? minute, int? second}) {
    return Time(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }
}
