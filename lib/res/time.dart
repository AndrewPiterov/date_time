import 'package:quiver/core.dart';

/// Time object
///
/// `Time(11,30,45)` is 11:30:45
class Time {
  final int hours;
  final int mins;
  final int secs;

  int get inMins => hours * 60 + mins;

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

  String toStringWithSeparator(String separator) =>
      toString().replaceAll(':', separator);

  // get isEmpty => label.isEmpty;

  // get label => "$hours:${mins < 10 ? '0$mins' : mins}";

  static Time corrected({required int hour}) {
    if (hour < 0) {
      return Time(0);
    }

    if (hour < 24) {
      return Time(hour);
    }

    if (hour == 24) {
      return Time(0);
    }

    final r = hour % 24;
    return Time(r);
  }

  // TimeOfDay get asDayOfTime => TimeOfDay(hour: hour, minute: minute);

  static Time fromStr(String? str) {
    if (str == null || str.isEmpty) {
      return Time(0);
    }

    final arr = str.split(':');

    final h = arr[0];
    final String m = arr.length > 1 ? arr[1] : '0';

    return Time(int.parse(h), mins: int.parse(m));
  }

  Time addHours(int amount) {
    final additional = amount * 60;
    final totalMinutes = inMins + additional;
    return Time.fromMinutes(totalMinutes);
  }

  Time addMinutes(int amount) {
    final totalMinutes = inMins + amount;
    return Time.fromMinutes(totalMinutes);
  }

  bool isAfter(Time? time, {bool orSame = false}) {
    if (time == null) {
      throw 'You could not compare null with Time!';
    }

    if (hours > time.hours) {
      return true;
    }

    if (hours < time.hours) {
      return false;
    }

    // hours are same - compare minutes
    if (mins > time.mins) {
      return true;
    }

    if (mins < time.mins) {
      return false;
    }

    return orSame;
  }

  bool timeLessThen(Time? b) {
    if (b == null) {
      return false;
    }

    return hours < b.hours || (hours == b.hours && mins < b.mins);
  }

  bool timeGreaterThen(Time b) {
    return b.timeLessThen(this);
  }

  /// Now
  static Time get now => Time(DateTime.now().hour, mins: DateTime.now().minute);

  // static Time from(TimeOfDay time) =>
  //     Time(hour: time.hour, minute: time.minute);

  ///
  factory Time.fromMinutes(int amount) {
    var h = (amount / 60).floor();

    if (h == 24) {
      h = 0;
    }

    if (h > 24) {
      final x = (h / 24).floor();
      h = x;
    }

    final m = amount % 60;
    return Time(h, mins: m);
  }

  // factory Time.fromMinutes(int minutes) {
  //   final h = minutes ~/ 60;
  //   final m = minutes % 60;
  //   return Time(h, mins: m);
  // }

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

  @override
  String toString() => [
        hours.toString().padLeft(2, '0'),
        mins.toString().padLeft(2, '0'),
        secs.toString().padLeft(2, '0'),
      ].join(':');
}
