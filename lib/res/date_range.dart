import 'package:date_time/res/date.dart';
import 'package:quiver/core.dart';

///
class DateRange {
  /// Initialize `DateRange`
  DateRange(this.start, this.end);

  Date start;
  Date end;

  bool get isValid => start < end;

  @override
  bool operator ==(Object other) =>
      other is DateRange && other.start == start && other.end == end;

  @override
  int get hashCode => hash2(
        start.hashCode,
        end.hashCode,
      );

  @override
  String toString() => '$start-$end';
}
