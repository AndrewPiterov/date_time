import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  given('DateTimeRange', () {
    final range = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    then('should be valid', () {
      range.isValid.should.beTrue();
    });

    then('toString() should return datetime', () {
      range
          .toString()
          .should
          .be('2023-01-02 00:00:00.000 - 2023-01-03 00:00:00.000');
    });
  });

  test('Two date time ranges should be equal', () {
    final range1 = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    final range2 = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    range1.should.be(range2);
    range1.hashCode.should.be(range2.hashCode);
  });

  group('copyWith', () {
    final range1 = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    test('copy start', () {
      range1.copyWith(start: DateTime(2023, 1, 3)).should.be(
            DateTimeRange(
              start: DateTime(2023, 1, 3),
              end: DateTime(2023, 1, 3),
            ),
          );
    });

    test('copy end', () {
      range1.copyWith(end: DateTime(2023, 1, 7)).should.be(
            DateTimeRange(
              start: DateTime(2023, 1, 2),
              end: DateTime(2023, 1, 7),
            ),
          );
    });
  });

  group('expand / expandOther', () {
    final range = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    final expandedRange = DateTimeRange(
      start: DateTime(2023),
      end: DateTime(2023, 1, 4),
    );

    final expandedRangeStart = DateTimeRange(
      start: DateTime(2023),
      end: DateTime(2023, 1, 3),
    );

    final expandedRangeEnd = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 4),
    );

    test('expandOther', () {
      range.expandOther(expandedRange).should.be(expandedRange);
      range.expandOther(expandedRangeStart).should.be(expandedRangeStart);
      range.expandOther(expandedRangeEnd).should.be(expandedRangeEnd);
    });

    test('expand', () {
      range.expand(DateTime(2023)).should.be(expandedRangeStart);
      range.expand(DateTime(2023, 1, 4)).should.be(expandedRangeEnd);
    });
  });

  group('duration', () {
    final duration = DateTime(2023, 1, 3).difference(DateTime(2023, 1, 2));
    final range = DateTimeRange(
      start: DateTime(2023, 1, 2),
      end: DateTime(2023, 1, 3),
    );

    test('test duration', () {
      range.duration.should.be(duration);
    });
  });
}
