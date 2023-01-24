import 'package:date_time/src/date.dart';
import 'package:date_time/src/extensions.dart';
import 'package:intl/intl.dart';
import 'package:quiver/core.dart';

/// An enum representation of month
enum MONTH {
  /// january
  january(number: 1),

  /// february
  february(number: 2),

  /// march
  march(number: 3),

  /// april
  april(number: 4),

  /// may
  may(number: 5),

  /// june
  june(number: 6),

  /// july
  july(number: 7),

  /// august
  august(number: 8),

  /// september
  september(number: 9),

  /// october
  october(number: 10),

  /// november
  november(number: 11),

  /// december
  december(number: 12);

  /// the month number
  final int number;

  /// Constructor
  const MONTH({required this.number});

  /// Convert a number to the enum value
  static MONTH fromNumber(int number) {
    try {
      return values.firstWhere((element) => element.number == number);
    } catch (e) {
      return january;
    }
  }

  /// Returns the month title based on locale
  String title([String? locale]) {
    final datetime = Date.epoch.setMonth(number).asDateTime;
    return DateFormat('MMMM', locale).format(datetime);
  }

  /// Return the abbreviation
  String shortTitle([String? locale]) {
    final datetime = Date.epoch.setMonth(number).asDateTime;
    return DateFormat('MMM', locale).format(datetime);
  }
}

/// A convenient class to work with only IsoWeek
class Month {
  /// A number that represent year
  final int year;

  /// A number that represent month
  final int month;

  /// Constructs the [Month] object
  const Month({required this.year, this.month = 1})
      : assert(month >= 1),
        assert(month <= 12);

  /// Const value for the first month of epoch that can be used as a default value
  static const Month epoch = Month(year: 1970);

  /// Const value for the first month in year 1 that can be used as a default value
  static const Month startOfTime = Month(year: 1);

  /// Const value to signify the end of time that can be used as a default value
  static const Month endOfTime = Month(year: 9999, month: 12);

  ///////////////////////////////////// FACTORIES

  /// Create Month from DateTime
  factory Month.fromDateTime(DateTime datetime) {
    return Month(year: datetime.year, month: datetime.month);
  }

  /// Create Month from Date
  factory Month.fromDate(Date date) {
    return Month(year: date.year, month: date.month);
  }

  /// Get the current Month
  factory Month.now() => Date.now().getMonth;

  /// Same as [Month.now]
  factory Month.thisMonth() => Month.now();

  /// Get last month
  factory Month.lastMonth() => Month.now().subWeeks(1);

  /// Get next month
  factory Month.nextMonth() => Month.now().addWeeks(1);

  /// Return the [Date] at the start of month
  Date get startOfMonth => Date(year: year, month: month);

  /// Return the [Date] at the end of month
  Date get endOfMonth => startOfMonth.endOfMonth;

  /// Get the enum value of month
  MONTH get getMONTH => MONTH.fromNumber(month);

  /// Returns the dates of the month
  Map<int, Date> get dates {
    final count = endOfMonth.day;
    final list = List.generate(count, (index) => startOfMonth.addDays(index));
    return {for (var date in list) date.day: date};
  }

  /// Convenient operator to get the date
  Date operator [](int day) {
    if (day < 1 || day > endOfMonth.day)
      throw RangeError.range(day, 1, endOfMonth.day);
    return startOfMonth.addDays(day - 1);
  }

  ///////////////////////////////////// SETTERS

  /// Create a new copy with updated values
  Month copyWith({int? year, int? month}) {
    return Month(year: year ?? this.year, month: month ?? this.month);
  }

  /// Set the year
  Month setYear(int year) => copyWith(year: year);

  /// Set the month by number
  Month setMonth(int month) => copyWith(month: month);

  /// Set the month by enum value
  Month setMONTH(MONTH month) => setMonth(month.number);

  ///////////////////////////////////// OPERATIONS

  /// Add a [Duration] to this month
  Month add(Duration duration) => endOfMonth.asDateTime.add(duration).getMonth;

  /// Subtract a [Duration] to this month
  Month subtract(Duration duration) => startOfMonth.subtract(duration).getMonth;

  /// Add weeks
  Month addDays(int amount) => endOfMonth.addDays(amount.abs()).getMonth;

  /// Add a certain amount of weeks to this week
  Month addWeeks(int amount) => endOfMonth.addWeeks(amount.abs()).getMonth;

  /// Add a certain amount of months to this week
  Month addMonths(int amount) => startOfMonth.addMonths(amount.abs()).getMonth;

  /// Add a certain amount of quarters to this week
  Month addQuarters(int amount) =>
      startOfMonth.addQuarters(amount.abs()).getMonth;

  /// Add a certain amount of years to this week
  Month addYears(int amount) => startOfMonth.addYears(amount.abs()).getMonth;

  /// Subtracts an amount of days from this week
  Month subDays(int amount) => startOfMonth.subDays(amount.abs()).getMonth;

  /// Subtracts an amount of months from this week
  Month subWeeks(int amount) => startOfMonth.addWeeks(-amount.abs()).getMonth;

  /// Subtracts an amount of months from this week
  Month subMonths(int amount) => startOfMonth.subMonths(amount.abs()).getMonth;

  /// Add a certain amount of quarters to this week
  Month subQuarters(int amount) =>
      startOfMonth.subQuarters(amount.abs()).getMonth;

  /// Subtracts an amount of years from this [Date]
  Month subYears(int amount) => startOfMonth.subYears(amount.abs()).getMonth;

  ///////////////////////////////////// COMPARISON

  /// Return true if [month] is after [other], false otherwise.
  bool isAfter(Month other) => startOfMonth.isAfter(other.startOfMonth);

  /// Return true if [month] is before [other], false otherwise.
  bool isBefore(Month other) => startOfMonth.isBefore(other.startOfMonth);

  /// Return true if other [isEqual] or [isAfter] to this date
  bool isSameOrAfter(Month other) =>
      startOfMonth.isSameOrAfter(other.startOfMonth);

  /// Return true if other [isEqual] or [isBefore] to this date
  bool isSameOrBefore(Month other) =>
      startOfMonth.isSameOrBefore(other.startOfMonth);

  /// Return true if month is this month
  bool get isThisMonth => this == Month.thisMonth();

  /// Return true if month is last month
  bool get isLastMonth => this == Month.lastMonth();

  /// Return true if month is next month
  bool get isNextMonth => this == Month.nextMonth();

  /// Greater than operator
  bool operator >(Month other) => isAfter(other);

  /// Greater or equals to operator
  bool operator >=(Month other) => isSameOrAfter(other);

  /// Less than operator
  bool operator <(Month other) => isBefore(other);

  /// Less than or equals to operator
  bool operator <=(Month other) => isSameOrBefore(other);

  ///////////////////////////////////// OBJECT OVERRIDES

  @override
  bool operator ==(Object other) =>
      other is Month && other.year == year && other.month == month;

  @override
  int get hashCode => hash2(
        year.hashCode,
        month.hashCode,
      );

  @override
  String toString() => toKey();

  ///////////////////////////////////// KEY

  /// Convert [Month] to a unique id
  String toKey() => format('yyyy-MM');

  /// Convert a unique id to [Month]
  static Month? fromKey(String key) => tryParse(key, format: 'yyyy-MM');

  ///////////////////////////////////// FORMAT

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Given user input, attempt to parse the [dateStr] into the anticipated
  /// format, treating it as being in the local timezone.
  ///
  /// If [dateStr] does not match our format, throws a [FormatException].
  /// This will accept dates whose values are not strictly valid, or strings
  /// with additional characters (including whitespace) after a valid date. For
  /// stricter parsing, use [dateStr].
  static Month parse(
    String dateStr, {
    String? format,
    bool utc = false,
  }) {
    if (format == null || format == '') {
      return DateTime.parse(dateStr).getMonth;
    }

    final formatter = DateFormat(format);
    final dateTimeFromStr = formatter.parse(dateStr, utc);
    return dateTimeFromStr.getMonth;
  }

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Month? tryParse(
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

  /// Short-hand to DateFormat
  String format([String? pattern, String? locale]) {
    return DateFormat(pattern, locale).format(startOfMonth.asDateTime);
  }
}
