import 'package:date_time/date_time.dart';
import 'package:date_time/res/time.dart';

class TimeRange {
  const TimeRange(this.start, this.end);

  final Time start;
  final Time end;

  int get durationInMinutes => end.inMins - start.inMins;

  bool get isValid {
    return end.isAfter(start);
  }

  bool earlyOrSameTime(TimeRange other) {
    return start.hours < other.start.hours ||
        (start.hours == other.start.hours && start.mins <= other.start.mins);
  }

  TimeRange upTo(Time end) {
    if (start >= end) {
      throw DateTimeError('End can\'t be early than Start');
    }
    return TimeRange(start, end);
  }

  bool contains(Time checkTime) {
    final inside = start <= checkTime && checkTime <= end;
    return inside;
  }

  bool isCross(TimeRange other) {
    final first = this.start.inMins <= other.start.inMins ? this : other;
    final last = first == this ? other : this;

    final aGreaterOrEqualC = first.start.inMins <= last.start.inMins;
    final cInsideFirst = last.start.inMins < first.end.inMins;

    return aGreaterOrEqualC && cInsideFirst;
  }

  // @override
  ///
  bool operator >=(TimeRange other) {
    if (other.runtimeType == TimeRange) {
      final res = start <= other.start && end >= other.end;
      return res;
    }
    return false;
  }

  // @override
  ///
  bool operator <=(TimeRange other) {
    if (other.runtimeType == TimeRange) {
      return start <= other.start && end <= other.end;
    }
    return false;
  }

  // bool operator <(TimeRange other) {
  //   return start < other.start && end < other.end;
  // }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType == TimeRange) {
      return start == other.start && end == other.end;
    }

    return false;
  }

  // Override hashCode using strategy from Effective Java,
  // Chapter 11.
  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + start.hashCode;
    result = 37 * result + end.hashCode;
    return result;
  }
}
