import 'package:date_time/src/date_time_error.dart';
import 'package:date_time/src/time.dart';

class TimeRange {
  /// Initialize new `TimeRange` instance
  const TimeRange(this.start, this.end);

  final Time start;

  final Time end;

  /// Get the duration of the range
  int get durationInMinutes => end.inMins - start.inMins;

  /// Check if `TimeRange` is valid
  bool get isValid {
    return end.isAfter(start);
  }

  bool earlyOrSameTime(TimeRange other) {
    return start.hour < other.start.hour ||
        (start.hour == other.start.hour && start.minute <= other.start.minute);
  }

  TimeRange upTo(Time end) {
    if (start >= end) {
      throw DateTimeError("End can't be early than Start");
    }
    return TimeRange(start, end);
  }

  bool contains(Time checkTime) {
    final inside = start <= checkTime && checkTime <= end;
    return inside;
  }

  bool isCross(TimeRange other) {
    final first = start.inMins <= other.start.inMins ? this : other;
    final last = first == this ? other : this;

    final aGreaterOrEqualC = first.start.inMins <= last.start.inMins;
    final cInsideFirst = last.start.inMins < first.end.inMins;

    return aGreaterOrEqualC && cInsideFirst;
  }

  ///
  bool operator >=(TimeRange other) {
    if (other.runtimeType == TimeRange) {
      final res = start <= other.start && end >= other.end;
      return res;
    }
    return false;
  }

  ///
  bool operator <=(TimeRange other) {
    if (other.runtimeType == TimeRange) {
      return start <= other.start && end <= other.end;
    }
    return false;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is TimeRange) {
      return start == other.start && end == other.end;
    }

    return false;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + start.hashCode;
    result = 37 * result + end.hashCode;
    return result;
  }

  @override
  String toString() => '[$start-$end]';
}
