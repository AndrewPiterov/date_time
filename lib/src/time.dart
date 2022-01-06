// ignore_for_file: constant_identifier_names

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
  const Time(
    this.hours, {
    this.mins = 0,
    this.secs = 0,
  })  : assert(hours >= 0),
        assert(hours < 24),
        assert(mins >= 0),
        assert(mins <= 60),
        assert(secs >= 0),
        assert(secs <= 60);

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
    return Time(h, mins: m, secs: s);
  }

  /// Represents hours
  final int hours;

  /// Represents minutes
  final int mins;

  /// Represents seconds
  final int secs;

  /// Represents the `Time` in minutes
  int get inMins => hours * 60 + mins;

  /// Represents the `Time` in seconds
  int get inSeconds => inMins * 60 + secs;

  /// Convert to `OverflowedTime` representation
  OverflowedTime get asOverflowed {
    if (this is OverflowedTime) {
      return this as OverflowedTime;
    }

    return OverflowedTime(hours: hours, days: 0, min: mins, sec: secs);
  }

  ///
  static const minutesInDay = 24 * 60;

  ///
  static const secondsInDay = 24 * 60 * 60;

  ///
  static const defaultSeparator = ':';

  /// Tries to onvert a string to `Time`
  ///
  /// [str] should be separated wit `:`, eg: '23:30:21' or `3:17`
  static Time? fromStr(String? str) {
    try {
      if (str == null || str.isEmpty) {
        return null;
      }

      final arr = str.split(':');

      final h = arr[0];
      final String m = arr.length > 1 ? arr[1] : '0';

      return Time(int.parse(h), mins: int.parse(m));
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
  // ignore: prefer_constructors_over_static_methods
  static Time get now {
    final dt = DateTime.now();
    return Time(
      dt.hour,
      mins: dt.minute,
      secs: dt.second,
    );
  }

  /// UTC Now
  // ignore: prefer_constructors_over_static_methods
  static Time get utcNow {
    final dt = DateTime.now().toUtc();
    return Time(
      dt.hour,
      mins: dt.minute,
      secs: dt.second,
    );
  }

  /// Round the time to next nearest
  Time roundToTheNearestMin(int stepInMin, {bool back = false}) {
    final m = mins;
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
      hours: hours,
      days: days,
      min: mins,
      sec: secs,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Time &&
      other.hours == hours &&
      other.mins == mins &&
      other.secs == secs;

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
          hours.toString(),
          mins.toString(),
          secs.toString(),
        ].join(':');
      case TimeStringFormat.Hm:
        return [
          hours.toString(),
          mins.toString(),
        ].join(':');
      case TimeStringFormat.HHmm:
        return [
          hours.toString().padLeft(2, '0'),
          mins.toString().padLeft(2, '0'),
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
      return const Time(0);
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
        hours.hashCode,
        mins.hashCode,
        secs.hashCode,
      );

  @override
  String toString() => [
        hours.toString().padLeft(2, '0'),
        mins.toString().padLeft(2, '0'),
        secs.toString().padLeft(2, '0'),
      ].join(defaultSeparator);
}
