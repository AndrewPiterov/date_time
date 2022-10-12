import 'package:clock/clock.dart';
import 'package:date_time/src/extensions.dart';
import 'package:intl/intl.dart';
import 'package:quiver/core.dart';

/// Date object
class Date {
  /// Day
  final int day;

  /// Month
  final int month;

  /// Year
  final int year;

  /// Initialize `Date` object
  const Date({
    required this.year,
    this.month = 1,
    this.day = 1,
  });

  ///
  Date.from(DateTime dt)
      : year = dt.year,
        month = dt.month,
        day = dt.day;

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Given user input, attempt to parse the [dateStr] into the anticipated
  /// format, treating it as being in the local timezone.
  ///
  /// If [dateStr] does not match our format, throws a [FormatException].
  /// This will accept dates whose values are not strictly valid, or strings
  /// with additional characters (including whitespace) after a valid date. For
  /// stricter parsing, use [dateStr].
  static Date parse(
    String dateStr, {
    String? format,
    bool utc = false,
  }) {
    if (format == null || format == '') {
      return DateTime.parse(dateStr).date;
    }

    final formatter = DateFormat(format);
    final dateTimeFromStr = formatter.parse(dateStr, utc);
    return dateTimeFromStr.date;
  }

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Date? tryParse(
    String dateStr, {
    String? format,
    bool utc = false,
  }) {
    try {
      return parse(
        dateStr,
        format: format,
        utc: utc,
      );
    } on FormatException {
      return null;
    }
  }

  /// Constructs a [Date] instance with current date in the
  /// local time zone.
  ///
  /// ```dart
  /// var thisInstant = Date.now();
  /// ```
  factory Date.now() => clock.now().date;

  /// Constructs a [Date] instance with current date in the
  /// UTC time zone.
  ///
  /// ```dart
  /// var thisInstant = Date.nowUtc();
  /// ```
  factory Date.nowUtc() => clock.now().toUtc().date;

  /// Today
  factory Date.today() => Date.from(clock.now());

  /// Tomorrow
  factory Date.tomorrow() => Date.today().nextDay;

  /// Tomorrow
  factory Date.yesterday() => Date.today().previousDay;

  String get withoutSeparator => DateFormat('yyyyMMdd').format(asDateTime);

  String withSeparator(String separator) =>
      DateFormat('yyyy${separator}MM${separator}dd').format(asDateTime);

  int get weekday => DateTime(year, month, day).weekday;

  DateTime get asDateTime => DateTime(year, month, day);

  DateTime get asUtcDateTime => DateTime.utc(year, month, day);

  /// Add a [Duration] to this date
  Date add(Duration duration) {
    final t = asUtcDateTime.add(duration);
    return Date(year: t.year, month: t.month, day: t.day);
  }

  /// Subtract a [Duration] to this date
  Date subtract(Duration duration) {
    final t = asUtcDateTime.subtract(duration);
    return Date(year: t.year, month: t.month, day: t.day);
  }

  /// Add days
  Date addDays(int amount) => add(Duration(days: amount));

  /// Add a certain amount of weeks to this date
  Date addWeeks(int amount) => addDays(amount * 7);

  /// Add a certain amount of months to this date
  Date addMonths(int amount) => setMonth(month + amount);

  /// Add a certain amount of quarters to this date
  Date addQuarters(int amount) => addMonths(amount * 3);

  /// Add a certain amount of years to this date
  Date addYears(int amount) => setYear(year + amount);

  /// Subtracts an amount of days from this [Date]
  Date subDays(int amount) => addDays(-amount);

  /// Subtracts an amount of months from this [Date]
  Date subMonths(int amount) => addMonths(-amount);

  /// Add a certain amount of quarters to this date
  Date subQuarters(int amount) => addQuarters(-amount);

  // DateTime subWeeks(amount)
  /// Subtracts an amount of years from this [Date]
  Date subYears(int amount) => addYears(-amount);

  Date setYear(int year) => DateTime.utc(year, month, day).date;

  Date setMonth(int month) => DateTime.utc(year, month, day).date;

  Date setDay(int day) => DateTime.utc(year, month, day).date;

  bool isAfter(Date other) => asDateTime.isAfter(other.asDateTime);

  bool isBefore(Date other) => asDateTime.isBefore(other.asDateTime);

  /// Return true if other [isEqual] or [isAfter] to this date
  bool isSameOrAfter(Date other) => this == other || isAfter(other);

  /// Return true if other [isEqual] or [isBefore] to this date
  bool isSameOrBefore(Date other) => this == other || isBefore(other);

  /// The day after this [Date]
  Date get nextDay => addDays(1);

  /// The day previous this [Date]
  Date get previousDay => addDays(-1);

  /// The month after this [Date]
  Date get nextMonth => setMonth(month + 1);

  /// The month previous this [Date]
  Date get previousMonth => setMonth(month - 1);

  /// The year after this [Date]
  Date get nextYear => setYear(year + 1);

  /// The year previous this [Date]
  Date get previousYear => setYear(year - 1);

  /// The week after this [Date]
  Date get nextWeek => addDays(7);

  /// The week previous this [Date]
  Date get previousWeek => subDays(7);

  /// Get a [Date] representing start of week of this [Date] in local time.
  Date get startOfWeek => weekday == DateTime.sunday ? this : subDays(weekday);

  /// Get a [Date] representing start of week (ISO week) of this [Date] in local time.
  Date get startOfISOWeek => subDays(weekday - 1);

  /// Get a [Date] representing start of week of this [Date] in local time.
  Date get startOfWeekend => subDays(DateTime.saturday - weekday);

  /// Get a [Date] representing start of month of this [Date] in local time.
  Date get startOfMonth => setDay(1);

  /// Get a [Date] representing start of year of this [Date] in local time.
  Date get startOfYear => DateTime(year).date;

  /// Return the end of ISO week for this date. The result will be in the local timezone.
  Date get endOfISOWeek => startOfISOWeek.addDays(6);

  /// Return the end of the week for this date. The result will be in the local timezone.
  Date get endOfWeek => startOfWeek.addDays(6);

  /// Get a [Date] representing end of weekend of this [Date] in local time.
  Date get endOfWeekend => startOfWeekend.addDays(1);

  /// Return the end of the year for this date. The result will be in the local timezone.
  Date get endOfYear => Date(year: year, month: DateTime.december).endOfMonth;

  /// Return the end of the month for this date. The result will be in the local timezone.
  Date get endOfMonth => Date(year: year, month: month + 1).subDays(1);

  /// Quarter 1-4
  int get quarter => (month + 2) ~/ 3;

  /// Quarter start month
  int get quarterStartMonth => quarterEndMonth - 2;

  /// Quarter end month
  int get quarterEndMonth => 3 * quarter;

  /// Start of quarter
  Date get startOfQuarter => Date(year: year, month: quarterStartMonth);

  /// End of quarter
  Date get endOfQuarter => Date(year: year, month: quarterEndMonth).endOfMonth;

  /// Get the week index
  int get getWeek => addDays(1).getISOWeek;

  /// Get the ISO week index
  int get getISOWeek {
    final woy = (_ordinalDate - weekday + 10) ~/ 7;

    // If the week number equals zero, it means that the given date belongs to the preceding (week-based) year.
    if (woy == 0) {
      // The 28th of December is always in the last week of the year
      return Date(year: year - 1, month: 12, day: 28).getISOWeek;
    }

    // If the week number equals 53, one must check that the date is not actually in week 1 of the following year
    if (woy == 53 &&
        DateTime(year).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }

    return woy;
  }

  int get _ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// Return true if this date day is monday
  bool get isMonday => weekday == DateTime.monday;

  /// Return true if this date day is tuesday
  bool get isTuesday => weekday == DateTime.tuesday;

  /// Return true if this date day is wednesday
  bool get isWednesday => weekday == DateTime.wednesday;

  /// Return true if this date day is thursday
  bool get isThursday => weekday == DateTime.thursday;

  /// Return true if this date day is friday
  bool get isFriday => weekday == DateTime.friday;

  /// Return true if this date day is saturday
  bool get isSaturday => weekday == DateTime.saturday;

  /// Return true if this date day is sunday
  bool get isSunday => weekday == DateTime.sunday;

  /// Is the given date the first day of a month?
  bool get isFirstDayOfMonth => isSameDay(startOfMonth);

  /// Return true if this date [isAfter] [Date.now]
  bool get isFuture => isAfter(Date.today());

  /// Is the given date the last day of a month?
  bool get isLastDayOfMonth => isSameDay(endOfMonth);

  /// Is the given date in the leap year?
  bool get isLeapYear =>
      (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0);

  /// Return true if this date [isBefore] [Date.now]
  bool get isPast => isBefore(Date.today());

  /// Check if this date is in the same day than other
  bool isSameDay(Date other) => this == other;

  /// Check if this date is in the same month than other
  bool isSameMonth(Date other) => startOfMonth == other.startOfMonth;

  /// Check if this date is in the same quarter
  bool isSameQuarter(Date other) => startOfQuarter == other.startOfQuarter;

  /// Check if this date is in the same week than other
  bool isSameWeek(Date other) => startOfWeek == other.startOfWeek;

  /// Check if this date is in the same iso week than other
  bool isSameISOWeek(Date other) => startOfISOWeek == other.startOfISOWeek;

  /// Check if this date is in the same year than other
  bool isSameYear(Date other) => year == other.year;

  /// Check if this date is in the same month than [Date.today]
  bool get isThisWeek => isSameWeek(Date.today());

  /// Check if this date is in the same month than [Date.today]
  bool get isThisIsoWeek => isSameISOWeek(Date.today());

  /// Check if this date is in the same month than [Date.today]
  bool get isThisMonth => isSameMonth(Date.today());

  /// Check if this date is in the same month than [Date.today]
  bool get isThisQuarter => isSameQuarter(Date.today());

  /// Check if this date is in the same year than [Date.today]
  bool get isThisYear => isSameYear(Date.today());

  /// Check if this date is in the same day than [Date.today]
  bool get isToday => isSameDay(Date.today());

  /// Check if this date is in the same day than [Date.today]
  bool get isTomorrow => isSameDay(Date.tomorrow());

  /// Check if this date is in the same day than [Date.today]
  bool get isYesterday => isSameDay(Date.yesterday());

  /// Return true if this [DateTime] is a saturday or a sunday
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  bool operator >(Date other) => isAfter(other);

  bool operator >=(Date other) => isSameOrAfter(other);

  bool operator <(Date other) => isBefore(other);

  bool operator <=(Date other) => isSameOrBefore(other);

  @override
  bool operator ==(Object other) =>
      other is Date &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => hash3(
        year.hashCode,
        month.hashCode,
        day.hashCode,
      );

  @override
  String toString() => DateFormat.yMd().format(asDateTime);

  Date copyWith({int? year, int? month, int? day}) {
    return Date(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }
}
