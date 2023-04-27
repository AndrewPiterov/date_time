import 'package:date_time/src/extensions.dart';

///
class DateTimeRange {
  ///
  DateTimeRange({
    required this.start,
    required this.end,
  }) : assert(!start.isAfter(end));

  ///
  final DateTime start;

  ///
  final DateTime end;

  ///
  bool get isValid => start <= end;

  ///
  Duration get duration => end.difference(start);

  @override
  bool operator ==(Object other) =>
      other is DateTimeRange && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => '$start - $end';

  ///
  DateTimeRange expand(DateTime datetime) {
    if (datetime.isBefore(start)) {
      return copyWith(start: datetime);
    } else if (datetime.isAfter(end)) {
      return copyWith(end: datetime);
    }
    return this;
  }

  ///
  DateTimeRange expandOther(DateTimeRange other) {
    if (other.start.isBefore(start) && other.end.isAfter(end)) {
      return copyWith(start: other.start, end: other.end);
    } else if (other.start.isBefore(start)) {
      return copyWith(start: other.start);
    } else if (other.end.isAfter(end)) {
      return copyWith(end: other.end);
    }
    return this;
  }

  ///
  DateTimeRange copyWith({DateTime? start, DateTime? end}) {
    return DateTimeRange(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }
}
