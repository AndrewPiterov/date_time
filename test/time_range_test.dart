import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

void main() {
  given('DateTime', () {
    final start = DateTime.now().time;
    final end = DateTime.now().add(const Duration(days: 1, minutes: 1)).time;

    final range = TimeRange(start, end);

    final range2 = TimeRange(
      start,
      end,
    );

    then('should be type of', () {
      range.should.beOfType<TimeRange>();
    });

    then('should be equal to', () {
      range.should.be(range2);
    });

    then('should be valid', () {
      range.isValid.should.beTrue();
    });

    when('invalid range', () {
      final invalidRange = TimeRange(
        end,
        start,
      );
      then('should be invalid', () {
        final res = invalidRange.isValid;
        res.should.beFalse();
      });
    });
  });

  test('Range toString', () {
    final string =
        const TimeRange(Time(hour: 1), Time(hour: 13, millisecond: 123))
            .toString();
    string.should.be('[01:00:00:000-13:00:00:123]');
  });

  test('durationInMinutes', () {
    const range = TimeRange(Time(hour: 1), Time(hour: 2));
    range.durationInMinutes.should.be(60);
  });

  group('comparisons', () {
    final start = DateTime.now().time;
    final end = DateTime.now().add(const Duration(days: 1, minutes: 1)).time;
    final range1 = TimeRange(start, end);
    final range2 = TimeRange(start, end);

    test('==', () {
      (range1 == range2).should.be(true);
      (range1 != range2).should.be(false);
      (range1.hashCode == range2.hashCode).should.be(true);
      (range1.hashCode != range2.hashCode).should.be(false);
    });

    test('earlyOrSameAs', () {
      range1.earlyOrSameTime(range2).should.be(true);
    });

    test('upTo', () {
      range1.upTo(end).should.be(range1);
      Should.throwError(() => range1.upTo(start));
    });

    test('contains', () {
      range1.contains(start).should.be(true);
      range1.contains(end).should.be(true);
    });

    test('isCross', () {
      range1.isCross(range2).should.be(true);
    });

    test('>=', () {
      (range1 >= range2).should.be(true);
    });

    test('<=', () {
      (range1 <= range2).should.be(true);
    });
  });
}
