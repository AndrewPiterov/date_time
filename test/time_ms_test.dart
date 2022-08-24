import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  //

  test('milliseconds', () {
    const time = Time(hour: 0, millisecond: 1);
    expect(time.millisecond, 1);
  });

  group('description', () {
    test('1 ms', () {
      Time.fromStr('1', formatType: TimeFormatType.millisecondLast)
          .should
          .be(Time.fromMilliseconds(1));
    });

    test('1000 ms', () {
      final t =
          Time.fromStr('01:000', formatType: TimeFormatType.millisecondLast);
      t.should.be(Time.fromMilliseconds(1000));
    });

    test('2 sec', () {
      Time.fromStr('02:00', formatType: TimeFormatType.millisecondLast)
          .should
          .be(Time.fromMilliseconds(2000));
    });

    test('1 min', () {
      Time.fromStr('01:00:00', formatType: TimeFormatType.millisecondLast)
          .should
          .be(
            const Time(
              hour: 0,
              minute: 1,
            ),
          );
    });

    test('1 hr', () {
      Time.fromStr('01:00:00:00', formatType: TimeFormatType.millisecondLast)
          .should
          .be(const Time(hour: 1));
    });
  });

  group('total milliseconds', () {
    test('only ms', () {
      const time = Time(hour: 0, millisecond: 1);
      expect(time.totalMilliseconds, 1);
    });

    test('with sec', () {
      const time = Time(hour: 0, second: 1, millisecond: 1);
      expect(time.totalMilliseconds, 1001);
    });

    test('with min', () {
      const time = Time(hour: 0, minute: 1, second: 1, millisecond: 1);
      expect(time.totalMilliseconds, 61001);
    });
  });
}
