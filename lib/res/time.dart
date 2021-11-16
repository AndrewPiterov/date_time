import 'package:date_time/date_time.dart';
import 'package:quiver/core.dart';

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
        assert(mins < 60),
        assert(secs >= 0),
        assert(secs < 60);

  /// Represents hours
  final int hours;

  /// Represents minutes
  final int mins;

  /// Represents seconds
  final int secs;

  /// Represents the `Time` in minutes
  int get inMins => hours * 60 + mins;

  /// Convert to `OverflowedTime` representation
  OverflowedTime get asOverflowed {
    if (this is OverflowedTime) {
      return this as OverflowedTime;
    }

    return OverflowedTime(hours: hours, days: 0, min: mins, sec: secs);
  }

  static const _minutesInDay = 24 * 60;
  static const _defaultSeparator = ':';

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
    final additional = amount * 60;
    final totalMinutes = inMins + additional;
    return Time.fromMinutes(totalMinutes);
  }

  /// Add minutes and may be `Oveflowed`
  Time addMinutes(int amount) {
    final totalMinutes = inMins + amount;
    return Time.fromMinutes(totalMinutes);
  }

  /// Now
  static Time get now {
    final dt = DateTime.now();
    return Time(
      dt.hour,
      mins: dt.minute,
      secs: dt.second,
    );
  }

  /// UTC Now
  static Time get utcNow {
    final dt = DateTime.now().toUtc();
    return Time(
      dt.hour,
      mins: dt.minute,
      secs: dt.second,
    );
  }

  ///
  factory Time.fromMinutes(int amount) {
    final isOveflowed = amount > _minutesInDay;
    if (isOveflowed) {
      final days = (amount / _minutesInDay).floor();
      final mins = amount % _minutesInDay;
      return Time.fromMinutes(mins).oveflowBy(days);
    }

    var h = (amount / 60).floor();

    if (h == 24) {
      h = 0;
    }

    final m = amount % 60;
    return Time(h, mins: m);
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

  ///
  bool isAfter(Time time, {bool orSame = false}) {
    return orSame ? this >= time : this > time;
  }

  ///
  bool isBefore(Time time, {bool orSame = false}) {
    return orSame ? this <= time : this < time;
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

  @override
  bool operator ==(Object other) =>
      other is Time &&
      other.hours == hours &&
      other.mins == mins &&
      other.secs == secs;

  @override
  int get hashCode => hash3(
        hours.hashCode,
        mins.hashCode,
        secs.hashCode,
      );

  /// Allowed formats `HH:mm:ss` and `HH:mm`
  String format([String format = 'HH:mm:ss']) {
    if (format == 'HH:mm:ss') {
      return toString();
    }

    if (format == 'HH:mm') {
      return [
        hours.toString().padLeft(2, '0'),
        mins.toString().padLeft(2, '0'),
      ].join(':');
    }

    return toString();
  }

  ///
  String toStringWithSeparator(String separator) =>
      toString().replaceAll(_defaultSeparator, separator);

  @override
  String toString() => [
        hours.toString().padLeft(2, '0'),
        mins.toString().padLeft(2, '0'),
        secs.toString().padLeft(2, '0'),
      ].join(_defaultSeparator);
}
