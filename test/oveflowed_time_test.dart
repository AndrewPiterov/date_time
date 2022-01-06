import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/res/res.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('calculate mins', () {
    const oveflowedTime = OverflowedTime(hours: 1, days: 1);

    oveflowedTime.inMins.should.be(25 * 60);
  });

  given('minutes of two days', () {
    const mins = 23 * 60;

    when('convert to Time', () {
      late Time time;

      before(() {
        time = Time.fromMinutes(mins);
      });

      then('time should be type of Time', () {
        time.should.beOfType<Time>();
      });

      then('start should be right', () {
        time.hours.should.be(23);
      });
    });
  });

  given('minutes of two days', () {
    const mins = 1500;

    when('convert to Time', () {
      late Time time;

      before(() {
        time = Time.fromMinutes(mins);
      });

      then('time should be oveflowed', () {
        time.should.beOfType<OverflowedTime>();
      });

      then('start should be right', () {
        time.hours.should.be(1);
      });
    });
  });
}
