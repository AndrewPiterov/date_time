import 'package:date_time/date_time.dart';
import 'package:date_time/res/time_range.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

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
    final string = const TimeRange(Time(1), Time(13)).toString();
    string.should.be('[01:00:00-13:00:00]');
  });
}
