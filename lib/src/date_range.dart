import 'package:quiver/core.dart';

import 'date.dart';

///
class DateRange {
  /// Initialize `DateRange`
  const DateRange(this.start, this.end);

  final Date start;
  final Date end;

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
