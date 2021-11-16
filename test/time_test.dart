// ignore_for_file: prefer_const_constructors
import 'package:date_time/date_time.dart';
import 'package:date_time/res/overflowed_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('compare time', () {
    const time = Time(21, mins: 01);
    const time2 = Time(21, mins: 01);

    time.should.be(time2);
  });

  test('compare time', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    time2.isAfter(time).should.beTrue();
  });

  test('compare time (2)', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    final res = time2 >= time;
    res.should.beTrue();
  });

  test('toString', () {
    const time = Time(2, mins: 1, secs: 7);
    time.toString().should.be('02:01:07');
  });

  test('toString with separator', () {
    const time = Time(2, mins: 1, secs: 7);
    time.toStringWithSeparator('-').should.be('02-01-07');
  });

  test('as overflowed', () {
    final time = Time(20).addHours(5);
    time.asOverflowed.days.should.be(1);
  });

  given('time', () {
    const time = Time(20);

    when('add hours', () {
      then('hours should be summarize', () {
        time.addHours(2).should.be(Time(22));
      });
    });

    when('add more hours for next day', () {
      late Time res;

      before(() {
        res = time.addHours(5);
      });

      then('type shoulde oveflowed', () {
        res.should.beOfType<OverflowedTime>();
      });

      then('shoulde be oveflowed by 1', () {
        (res as OverflowedTime).days.should.be(1);
      });

      then('hours shoudld be corrected', () {
        res.should.be(Time(1));
      });
    });
  });

  group('comparison', () {
    const time = Time(1);
    const time1 = Time(1);
    const time2 = Time(2);
    test('not equal', () {
      (time != time2).should.beTrue();
    });

    test('before', () {
      (time < time2).should.beTrue();
    });

    test('after', () {
      (time2 > time).should.beTrue();
    });

    test('before or equal', () {
      (time1 <= time1).should.beTrue();
    });

    test('after or equal', () {
      (time1 >= time1).should.beTrue();
    });
  });

  group('roundToTheNearestMin', () {
    given('Time', () {
      const time = Time(10, mins: 10);

      then('round to prev 15', () {
        final res = time.roundToTheNearestMin(15, back: true);
        res.hours.should.be(10);
        res.mins.should.be(0);
      });

      then('round to prev 10', () {
        final res = time.roundToTheNearestMin(10, back: true);
        res.hours.should.be(10);
        res.mins.should.be(10);
      });

      then('round to next 30', () {
        final res = time.roundToTheNearestMin(30);
        res.hours.should.be(10);
        res.mins.should.be(30);
      });
    });

    given('Another Time', () {
      const time = Time(21, mins: 55);

      then('round to next 30', () {
        final res = time.roundToTheNearestMin(30);
        res.hours.should.be(22);
        res.mins.should.be(00);
      });
    });

    given('Another Time', () {
      const time = Time(21, mins: 21);

      then('round to next 15', () {
        final res = time.roundToTheNearestMin(15);
        res.hours.should.be(21);
        res.mins.should.be(30);
      });

      then('round to prev 15', () {
        final res = time.roundToTheNearestMin(15, back: true);
        res.hours.should.be(21);
        res.mins.should.be(15);
      });

      then('round to next 60', () {
        final res = time.roundToTheNearestMin(60);
        res.hours.should.be(22);
        res.mins.should.be(0);
      });
    });
  });
}
