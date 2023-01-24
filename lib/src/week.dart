import 'package:date_time/src/date.dart';
import 'package:date_time/src/extensions.dart';
import 'package:intl/intl.dart';

/// Enum representation of day of week
enum DAY {
  /// Monday
  monday(number: 1),

  /// Tuesday
  tuesday(number: 2),

  /// Wednesday
  wednesday(number: 3),

  /// Thursday
  thursday(number: 4),

  /// Friday
  friday(number: 5),

  /// Saturday
  saturday(number: 6),

  /// Sunday
  sunday(number: 7);

  /// ISO number of the day of week
  final int number;

  /// Constructor
  const DAY({required this.number});

  /// Returns the [DAY] enum value based on day of week iso number
  static DAY fromNumber(int number) {
    return values.firstWhere((element) => element.number == number);
  }

  /// Returns the day of week title based on locale
  String title([String? locale]) {
    final dayOfWeek =
        Week.firstISOWeekOfEpoch.startOfWeek.addDays(number - 1).asDateTime;
    return DateFormat('EEEE', locale).format(dayOfWeek);
  }

  /// Return the abbreviation of day - useful for calendar views.
  String shortTitle([String? locale]) {
    final dayOfWeek =
        Week.firstISOWeekOfEpoch.startOfWeek.addDays(number - 1).asDateTime;
    return DateFormat('E', locale).format(dayOfWeek);
  }

  /// Return the first letter of day - useful for alarm or smaller views.
  String acronym([String? locale]) {
    return shortTitle(locale)[0];
  }
}

/// A convenient class to work with only Week
class Week {
  /// A number representing the year this week belongs to
  // final int year;

  /// A number representing the week (currently only iso week is supported)
  // final int week;

  /// The start of the week, must be sunday or monday
  final Date startOfWeek;

  /// A flag to determine if this week should be treated as iso week (starts monday).
  /// By default, iso week is used. To change this, pass a false value to the constructor.
  // final bool iso;

  /// Constructs the week
  const Week({required this.startOfWeek});

  /// Const value for the first week of epoch that can be used as a default value
  static Week firstISOWeekOfEpoch = Week.startWeek(Date.epoch.startOfISOWeek);

  /// Const value for the first week of year 1 that can be used as a default value
  static Week firstISOWeekOfTime =
      Week.startWeek(Date.startOfTime.startOfISOWeek);

  /// Const value to signify the end of time that can be used as a default value
  static Week lastISOWeekOfTime = Week.startWeek(Date.endOfTime.startOfISOWeek);

  ///////////////////////////////////// FACTORIES

  /// Create Week from start [Date]
  factory Week.startWeek(Date date) {
    return Week(startOfWeek: date);
  }

  /// Create Week from DateTime
  factory Week.startDateTime(DateTime datetime) {
    return Week.startWeek(datetime.date);
  }

  /// Create a sunday Week (week starting on Sunday) from [Date]
  factory Week.week(Date date) {
    return Week.startWeek(date.startOfWeek);
  }

  /// Create the ISO week (week starting Monday) from [date]
  factory Week.isoWeek(Date date) {
    return Week.startWeek(date.startOfISOWeek);
  }

  /// When [iso] is true of absent, will return the current week starting on Monday
  /// When false, will return the current week starting on Sunday
  factory Week.now({bool iso = true}) =>
      iso ? Week.isoWeek(Date.now()) : Week.week(Date.now());

  /// Same as [Week.now]
  factory Week.thisWeek({bool iso = true}) => Week.now(iso: iso);

  /// Get last week
  factory Week.lastWeek({bool iso = true}) => Week.now(iso: iso).subWeeks(1);

  /// Get next week
  factory Week.nextWeek({bool iso = true}) => Week.now(iso: iso).addWeeks(1);

  ///////////////////////////////////// GETTERS

  /// Returns the next week relative to this week
  Week get next => addWeeks(1);

  /// Returns the previous week relative to this week
  Week get previous => subWeeks(1);

  /// Get the week index of week
  int get weekIndex => startOfWeek.getWeek;

  /// Get the week index of ISO week
  int get isoWeekIndex => startOfWeek.getISOWeek;

  /// Get the date for the end of week - this is always a saturday or sunday
  Date get endOfWeek => startOfWeek.addDays(6);

  /// Returns [true] if week starts monday
  bool get isISOWeek => startOfWeek.getDAY == DAY.monday;

  /// Returns the [startOfWeek] as [DAY]
  DAY get startDay => startOfWeek.getDAY;

  /// Returns [endOfWeek] as [DAY];
  DAY get endDay => endOfWeek.getDAY;

  /// Returns the dates of the week
  Map<DAY, Date> get dates {
    final list = List.generate(7, (index) => startOfWeek.addDays(index));
    return {for (var date in list) date.getDAY: date};
  }

  /// Returns the monday [Date] of the week
  Date get monday => dates[DAY.monday]!;

  /// Returns the tuesday [Date] of the week
  Date get tuesday => dates[DAY.tuesday]!;

  /// Returns the wednesday [Date] of the week
  Date get wednesday => dates[DAY.wednesday]!;

  /// Returns the thursday [Date] of the week
  Date get thursday => dates[DAY.thursday]!;

  /// Returns the friday [Date] of the week
  Date get friday => dates[DAY.friday]!;

  /// Returns the saturday [Date] of the week
  Date get saturday => dates[DAY.saturday]!;

  /// Returns the sunday [Date] of the week
  Date get sunday => dates[DAY.sunday]!;

  /// Convenient operator to get the date of a given week day
  Date operator [](DAY day) => dates[day]!;

  ///////////////////////////////////// SETTERS

  /// Create a new copy with updated values
  Week copyWith({Date? startOfWeek}) {
    return Week(startOfWeek: startOfWeek ?? this.startOfWeek);
  }

  /// Set the year
  Week setStartOfWeek(Date startOfWeek) => copyWith(startOfWeek: startOfWeek);

  ///////////////////////////////////// OPERATIONS

  /// Return the difference in weeks
  int difference(Week other) => startOfWeek.difference(other.startOfWeek);

  /// Add a certain amount of weeks to this week
  Week addWeeks(int amount) =>
      Week.startWeek(startOfWeek.addWeeks(amount.abs()));

  /// Add a certain amount of years to this week
  Week addYears(int amount) => addWeeks(52);

  /// Subtracts an amount of months from this week
  Week subWeeks(int amount) =>
      Week.startWeek(startOfWeek.subWeeks(amount.abs()));

  /// Subtracts an amount of years from this [Date]
  Week subYears(int amount) => subWeeks(52);

  ///////////////////////////////////// COMPARISON

  /// Return true if [startOfWeek] is after [other], false otherwise.
  bool isAfter(Week other) => startOfWeek.isAfter(other.startOfWeek);

  /// Return true if [startOfWeek] is before [other], false otherwise.
  bool isBefore(Week other) => startOfWeek.isBefore(other.startOfWeek);

  /// Return true if other [isEqual] or [isAfter] to this date
  bool isSameOrAfter(Week other) =>
      startOfWeek.isSameOrAfter(other.startOfWeek);

  /// Return true if other [isEqual] or [isBefore] to this date
  bool isSameOrBefore(Week other) =>
      startOfWeek.isSameOrBefore(other.startOfWeek);

  /// Return true if week is this week
  bool get isThisWeek => this == Week.thisWeek();

  /// Return true if week is last week
  bool get isLastWeek => this == Week.lastWeek();

  /// Return true if week is next week
  bool get isNextWeek => this == Week.nextWeek();

  /// Greater than operator
  bool operator >(Week other) => isAfter(other);

  /// Greater or equals to operator
  bool operator >=(Week other) => isSameOrAfter(other);

  /// Less than operator
  bool operator <(Week other) => isBefore(other);

  /// Less than or equals to operator
  bool operator <=(Week other) => isSameOrBefore(other);

  ///////////////////////////////////// OBJECT OVERRIDES

  @override
  bool operator ==(Object other) =>
      other is Week && other.startOfWeek == startOfWeek;

  @override
  int get hashCode => startOfWeek.hashCode;

  @override
  String toString() => toKey();

  ///////////////////////////////////// KEY

  String toKey() => startOfWeek.format('yyyy-MM-dd');

  /// Parse from string in the format yyyy-ww - useful for unique week id
  static Week? fromKey(String key) {
    final date = Date.tryParse(key, format: 'yyyy-MM-dd');
    return date == null ? null : Week(startOfWeek: date);
  }

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
  static Week parse(
    String dateStr, {
    String? format,
    bool utc = false,
    bool iso = true,
  }) {
    if (format == null || format == '') {
      return iso
          ? DateTime.parse(dateStr).isoWeek
          : DateTime.parse(dateStr).week;
    }

    final formatter = DateFormat(format);
    final date = formatter.parse(dateStr, utc).date;
    return iso ? date.isoWeek : date.week;
  }

  /// Constructs a new [DateTime] instance based on [dateStr].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Week? tryParse(
    String dateStr, {
    String? format,
    bool utc = false,
    bool iso = true,
  }) {
    try {
      return parse(
        dateStr,
        format: format,
        utc: utc,
        iso: iso,
      );
    } on FormatException {
      return null;
    }
  }
}
