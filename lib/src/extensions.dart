import 'package:date_time/src/date.dart';
import 'package:date_time/src/month.dart';
import 'package:date_time/src/time.dart';
import 'package:date_time/src/week.dart';
import 'package:date_time/src/year.dart';
import 'package:intl/intl.dart';

/// Extensions on [DateTime]
extension DateTimeExtensions on DateTime {
  /// Create a [Date] instance from a [DateTime].
  Date get date => Date(year: year, month: month, day: day);

  /// Create a [Time] instance from a [DateTime].
  Time get time => Time(hour: hour, minute: minute, second: second);

  /// Create a [Week] instance from a [DateTime]
  Week get week {
    return Week.week(date);
  }

  /// Create a ISO [Week] instance from [DateTime]
  Week get isoWeek {
    return Week.isoWeek(date);
  }

  /// Create a [Month] instance from a [DateTime]
  Month get getMonth {
    return Month.fromDateTime(this);
  }

  /// Create a [Year] instance from a [DateTime]
  Year get getYear {
    return Year.fromDateTime(this);
  }

  /// Get the number of weeks in an ISO week-numbering year
  int get getISOWeeksInYear {
    return DateTime(year, 12, 28).getISOWeek;
  }

  /// Get the ISO week index
  int get getISOWeek {
    final woy = (_ordinalDate - weekday + 10) ~/ 7;

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return DateTime(year - 1, 12, 28).getISOWeek;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  /// Returns the year for this [DateTime] ISO week
  int get yearOfISOWeek {
    final woy = (_ordinalDate - weekday + 10) ~/ 7;

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return year - 1;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return year + 1;
    }

    return woy;
  }

  int get _ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  ///////////////////////////////////// COMPARISON

  /// Is the given date in the leap year?
  bool get isLeapYear => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);

  /// Check if this date is in the same year than other
  bool isSameYear(DateTime other) => year == other.year;

  /// Check if the date is within [start] and [end]
  bool isWithinRange(DateTime start, DateTime end) =>
      this >= start && this <= end;

  /// Check if the date is out side [start] and [end]
  bool isOutsideRange(DateTime start, DateTime end) =>
      !isWithinRange(start, end);

  /// Check if a date is [equals] to other
  bool isEqual(DateTime other) => this == other;

  /// Return true if other [isEqual] or [isAfter] to this date
  bool isSameOrAfter(DateTime other) => this == other || isAfter(other);

  /// Return true if other [isEqual] or [isBefore] to this date
  bool isSameOrBefore(DateTime other) => this == other || isBefore(other);

  /// Greater than
  bool operator >(DateTime other) => isAfter(other);

  /// Greater than or equal
  bool operator >=(DateTime other) => isSameOrAfter(other);

  /// Less than
  bool operator <(DateTime other) => isBefore(other);

  /// Less than or equal
  bool operator <=(DateTime other) => isSameOrBefore(other);

  ///////////////////////////////////// OPERATION

  /// Adds this DateTime and Duration and returns the sum as a new DateTime object.
  DateTime operator +(Duration duration) => add(duration);

  /// Subtracts the Duration from this DateTime returns the difference as a new DateTime object.
  DateTime operator -(Duration duration) => subtract(duration);

  /// Add a certain amount of days to this date
  DateTime addDays(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day + amount, hour, minute, second,
              millisecond, microsecond)
          : add(Duration(days: amount));

  /// Add a certain amount of hours to this date
  DateTime addHours(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour + amount, minute, second,
              millisecond, microsecond)
          : add(Duration(hours: amount));

  /// Add a certain amount of minutes to this date
  DateTime addMinutes(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour, minute + amount, second,
              millisecond, microsecond)
          : add(Duration(minutes: amount));

  /// Add a certain amount of milliseconds to this date
  DateTime addMilliseconds(int amount) => add(Duration(milliseconds: amount));

  /// Add a certain amount of microseconds to this date
  DateTime addMicroseconds(int amount) => add(Duration(microseconds: amount));

  /// Add a certain amount of seconds to this date
  DateTime addSeconds(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour, minute, second + amount,
              millisecond, microsecond)
          : add(Duration(seconds: amount));

  /// Add a certain amount of months to this date
  DateTime addMonths(int amount) => copyWith(month: month + amount);

  /// Add a certain amount of quarters to this date
  DateTime addQuarters(int amount) => addMonths(amount * 3);

  /// Add a certain amount of weeks to this date
  DateTime addWeeks(int amount) => addDays(amount * 7);

  /// Add a certain amount of years to this date
  DateTime addYears(int amount) => copyWith(year: year + amount);

  /// Subtract a certain amount of days from this date
  DateTime subDays(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day - amount, hour, minute, second,
              millisecond, microsecond)
          : subtract(Duration(days: amount));

  /// Subtract a certain amount of hours from this date
  DateTime subHours(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour - amount, minute, second,
              millisecond, microsecond)
          : subtract(Duration(hours: amount));

  /// Subtract a certain amount of minutes from this date
  DateTime subMinutes(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour, minute - amount, second,
              millisecond, microsecond)
          : subtract(Duration(minutes: amount));

  /// Subtract a certain amount of milliseconds to this date
  DateTime subMilliseconds(int amount) =>
      subtract(Duration(milliseconds: amount));

  /// Subtract a certain amount of microseconds from this date
  DateTime subMicroseconds(int amount) =>
      subtract(Duration(microseconds: amount));

  /// Subtract a certain amount of seconds from this date
  DateTime subSeconds(int amount, {bool ignoreDaylightSavings = false}) =>
      ignoreDaylightSavings
          ? DateTime(year, month, day, hour, minute, second - amount,
              millisecond, microsecond)
          : subtract(Duration(seconds: amount));

  /// Subtract a certain amount of months from this date
  DateTime subMonths(int amount) => copyWith(month: month - amount);

  /// Subtract a certain amount of quarters from this date
  DateTime subQuarters(int amount) => addMonths(-amount * 3);

  /// Subtract a certain amount of weeks from this date
  DateTime subWeeks(int amount) => addDays(-amount * 7);

  /// Subtract a certain amount of years from this date
  DateTime subYears(int amount) => copyWith(year: year - amount);

  ///////////////////////////////////// KEY

  /// Convert [DateTime] to a unique id
  String get key => toIso8601String();

  /// Convert a unique id to [DateTime]
  static DateTime? fromKey(String key) => DateTime.tryParse(key);

  /// Short-hand to DateFormat
  String format([String? pattern, String? locale]) {
    return DateFormat(pattern, locale).format(this);
  }

  /// Get a [DateTime] representing start of Day of this [DateTime] in local time.
  DateTime get startOfDay =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  /// Return the end of a day for this date. The result will be in the local timezone.
  DateTime get endOfDay => copyWith(
      hour: 23, minute: 59, second: 59, millisecond: 999, microsecond: 999);

  /// Convenient copy with method
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return isUtc
        ? DateTime.utc(
            year ?? this.year,
            month ?? this.month,
            day ?? this.day,
            hour ?? this.hour,
            minute ?? this.minute,
            second ?? this.second,
            millisecond ?? this.millisecond,
            microsecond ?? this.microsecond,
          )
        : DateTime(
            year ?? this.year,
            month ?? this.month,
            day ?? this.day,
            hour ?? this.hour,
            minute ?? this.minute,
            second ?? this.second,
            millisecond ?? this.millisecond,
            microsecond ?? this.microsecond,
          );
  }
}

/// Extensions on [DateFormat]
extension DateFormatExtensions on DateFormat {
  /// Format a [Date] instance.
  String formatDate(Date date) {
    return format(date.asDateTime);
  }
}
