import 'package:date_time/src/date.dart';
import 'package:date_time/src/extensions.dart';
import 'package:date_time/src/month.dart';
import 'package:date_time/src/week.dart';
import 'package:intl/intl.dart';

/// A convenient class to work with only iso year
class Year {
  /// A number that represent year
  final int year;

  /// Constructs the [Year] object
  const Year(this.year);

  ///////////////////////////////////// CONST

  /// Const value for the year of epoch that can be used as a default value
  static const Year epoch = Year(1970);

  /// Const value for year 1 that can be used as a default value
  static const Year startOfTime = Year(1);

  /// Const value to signify the end of time that can be used as a default value
  static const Year endOfTime = Year(9999);

  ///////////////////////////////////// FACTORIES

  /// Create Year from DateTime
  factory Year.fromDateTime(DateTime datetime) {
    return Year(datetime.year);
  }

  /// Create Year from Date
  factory Year.fromDate(Date date) {
    return Year(date.year);
  }

  /// Get the current year
  factory Year.now() => Date.now().getYear;

  /// Same as [Year.now]
  factory Year.thisYear() => Year.now();

  /// Get last year
  factory Year.lastYear() => Year.now().subYears(1);

  /// Get next year
  factory Year.nextYear() => Year.now().addYears(1);

  ///////////////////////////////////// GETTERS

  /// Get the date for the start of year
  Date get startOfYear => Date(year: year);

  /// Get the date for the end of year
  Date get endOfYear => startOfYear.endOfYear;

  /// Get the first week of the year
  Week get firstWeek {
    final yearOfWeek = startOfYear.yearOfWeek;
    if (yearOfWeek == year) {
      // yearOfWeek is the same year, return the start of week for 1st of Jan
      return Week.week(startOfYear);
    } else {
      // yearOfWeek must be previous year, return the next week instead
      return Week.week(startOfYear.addWeeks(1));
    }
  }

  /// Get the first ISO week of the year
  Week get firstISOWeek {
    final yearOfWeek = startOfYear.yearOfISOWeek;
    if (yearOfWeek == year) {
      // yearOfWeek is the same year, return the start of week for 1st of Jan
      return Week.isoWeek(startOfYear);
    } else {
      // yearOfWeek must be previous year, return the next week instead
      return Week.isoWeek(startOfYear.addWeeks(1));
    }
  }

  /// Get the last week of the year
  Week get lastWeek {
    final yearOfWeek = endOfYear.yearOfWeek;
    if (yearOfWeek == year) {
      // yearOfWeek is the same year, return the start of week for 31st of Dec
      return Week.week(endOfYear);
    } else {
      // yearOfWeek must be next year, return the previous week instead
      return Week.week(endOfYear.subWeeks(1));
    }
  }

  /// Get the last week of the year
  Week get lastISOWeek {
    final yearOfWeek = endOfYear.yearOfISOWeek;
    if (yearOfWeek == year) {
      // yearOfWeek is the same year, return the start of week for 31st of Dec
      return Week.isoWeek(endOfYear);
    } else {
      // yearOfWeek must be next year, return the previous week instead
      return Week.isoWeek(endOfYear.subWeeks(1));
    }
  }

  /// Returns the dates of the year
  Map<int, Date> get dates {
    final count = startOfYear.isLeapYear ? 366 : 365;
    final list = List.generate(count, (index) => startOfYear.addDays(index));
    int index = 1;
    return {for (var date in list) index++: date};
  }

  /// Returns the weeks of the year (week starting sunday)
  Map<int, Week> get weeks {
    final list = List.generate(52, (index) => firstWeek.addWeeks(index));
    return {for (var week in list) week.weekIndex: week};
  }

  /// Returns the iso weeks of the year (week starting monday)
  Map<int, Week> get isoWeeks {
    final list = List.generate(52, (index) => firstISOWeek.addWeeks(index));
    return {for (var week in list) week.isoWeekIndex: week};
  }

  /// Returns the months of the year
  Map<MONTH, Month> get months {
    final list =
        List.generate(12, (index) => Month(year: year).addMonths(index));
    return {for (var month in list) month.getMONTH: month};
  }

  /// Returns january
  Month get january => Month(year: year);

  /// Returns february
  Month get february => Month(year: year).addMonths(1);

  /// Returns march
  Month get march => Month(year: year).addMonths(2);

  /// Returns april
  Month get april => Month(year: year).addMonths(3);

  /// Returns may
  Month get may => Month(year: year).addMonths(4);

  /// Returns june
  Month get june => Month(year: year).addMonths(5);

  /// Returns july
  Month get july => Month(year: year).addMonths(6);

  /// Returns august
  Month get august => Month(year: year).addMonths(7);

  /// Returns september
  Month get september => Month(year: year).addMonths(8);

  /// Returns october
  Month get october => Month(year: year).addMonths(9);

  /// Returns november
  Month get november => Month(year: year).addMonths(10);

  /// Returns december
  Month get december => Month(year: year).addMonths(11);

  ///////////////////////////////////// SETTERS

  /// Create a new copy with updated values
  Year copyWith({int? year}) {
    return Year(year ?? this.year);
  }

  /// Set the year
  Year setYear(int year) => copyWith(year: year);

  ///////////////////////////////////// OPERATIONS

  /// Add a [Duration] to this week
  Year add(Duration duration) => endOfYear.add(duration).getYear;

  /// Subtract a [Duration] to this week
  Year subtract(Duration duration) => startOfYear.subtract(duration).getYear;

  /// Add a certain amount of days to the end of the year
  Year addDays(int amount) => endOfYear.addDays(amount.abs()).getYear;

  /// Add a certain amount of weeks to the end of the year
  Year addWeeks(int amount) => endOfYear.addWeeks(amount.abs()).getYear;

  /// Add a certain amount of months to the end of the year
  Year addMonths(int amount) => endOfYear.addMonths(amount.abs()).getYear;

  /// Add a certain amount of quarters to the end of the year
  Year addQuarters(int amount) => endOfYear.addQuarters(amount.abs()).getYear;

  /// Add a certain amount of years to the end of the year
  Year addYears(int amount) => copyWith(year: year + amount.abs());

  /// Subtracts an amount of days from the start of year
  Year subDays(int amount) => startOfYear.subDays(amount.abs()).getYear;

  /// Subtracts an amount of weeks from the start of year
  Year subWeeks(int amount) => startOfYear.addWeeks(-amount.abs()).getYear;

  /// Subtracts an amount of months from the start of year
  Year subMonths(int amount) => startOfYear.subMonths(amount.abs()).getYear;

  /// Subtracts an amount of quarters from the start of year
  Year subQuarters(int amount) => startOfYear.subQuarters(amount.abs()).getYear;

  /// Subtracts an amount of years from this year.
  Year subYears(int amount) => copyWith(year: year - amount.abs());

  ///////////////////////////////////// COMPARISON

  /// Return true if [year] is after [other], false otherwise.
  bool isAfter(Year other) => year > other.year;

  /// Return true if [year] is before [other], false otherwise.
  bool isBefore(Year other) => year < other.year;

  /// Return true if other [isEqual] or [isAfter] to this date
  bool isSameOrAfter(Year other) => year >= other.year;

  /// Return true if other [isEqual] or [isBefore] to this date
  bool isSameOrBefore(Year other) => year <= other.year;

  /// Return true if year is this year
  bool get isThisYear => this == Year.thisYear();

  /// Return true if year is last year
  bool get isLastYear => this == Year.lastYear();

  /// Return true if year is next year
  bool get isNextYear => this == Year.nextYear();

  /// Greater than operator
  bool operator >(Year other) => isAfter(other);

  /// Greater or equals to operator
  bool operator >=(Year other) => isSameOrAfter(other);

  /// Less than operator
  bool operator <(Year other) => isBefore(other);

  /// Less than or equals to operator
  bool operator <=(Year other) => isSameOrBefore(other);

  ///////////////////////////////////// OBJECT OVERRIDES

  @override
  bool operator ==(Object other) => other is Year && other.year == year;

  @override
  int get hashCode => year.hashCode;

  @override
  String toString() => key;

  ///////////////////////////////////// KEY

  /// Convert [Year] to a unique id
  String get key => format('yyyy');

  /// Convert a unique id to [Year]
  static Year? fromKey(String key) => tryParse(key, format: 'yyyy');

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
  static Year parse(
    String dateStr, {
    String? format,
    bool utc = false,
  }) {
    if (format == null || format == '') {
      return DateTime.parse(dateStr).getYear;
    }

    final formatter = DateFormat(format);
    final dateTimeFromStr = formatter.parse(dateStr, utc);
    return dateTimeFromStr.getYear;
  }

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Year? tryParse(
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
    return DateFormat(pattern, locale).format(startOfYear.asDateTime);
  }
}
