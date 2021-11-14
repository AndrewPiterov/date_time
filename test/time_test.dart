// ignore_for_file: prefer_const_constructors
import 'package:date_time/date_time.dart';
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
