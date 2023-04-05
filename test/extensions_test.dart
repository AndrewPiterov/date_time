import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('DateTime extensions', () {
    final datetime = DateTime(2023, 2, 2);

    test('getISOWeek', () {
      datetime.getISOWeek.should.be(5);
    });

    test('getIsoWeeksInYear', () {
      datetime.getISOWeeksInYear.should.be(52);
    });

    test('yearOfISOWeek', () {
      datetime.yearOfISOWeek.should.be(2023);
      DateTime(2023).yearOfISOWeek.should.be(2022);
    });

    test('yearOfISOWeek', () {
      datetime.yearOfISOWeek.should.be(2023);
      DateTime(2023).yearOfISOWeek.should.be(2022);
    });

    test('isLeapYear', () {
      DateTime(2020).isLeapYear.should.be(true);
      DateTime(2024).isLeapYear.should.be(true);
    });

    test('isLeapYear', () {
      DateTime(2020).isLeapYear.should.be(true);
      DateTime(2024).isLeapYear.should.be(true);
    });

    test('isSameYear', () {
      DateTime(2020, 2, 2).isSameYear(DateTime(2020, 3, 2)).should.be(true);
      DateTime(2020, 2, 2).isSameYear(DateTime(2021, 3, 2)).should.be(false);
    });

    test('isWithinRange', () {
      DateTime(2020, 2, 2)
          .isWithinRange(DateTime(2020), DateTime(2020, 3, 2))
          .should
          .be(true);
      DateTime(2021, 2, 2)
          .isWithinRange(DateTime(2020), DateTime(2020, 3, 2))
          .should
          .be(false);
    });

    test('isOutsideRange', () {
      DateTime(2020, 2, 2)
          .isOutsideRange(DateTime(2020), DateTime(2020, 3, 2))
          .should
          .be(false);
      DateTime(2021, 2, 2)
          .isOutsideRange(DateTime(2020), DateTime(2020, 3, 2))
          .should
          .be(true);
    });
  });

  group('Testing date time extension operations', () {
    const oneDay = Duration(days: 1);
    test('Add/subtract operation', () {
      (DateTime(2023) + oneDay).should.be(DateTime(2023, 1, 2));
      (DateTime(2023) - oneDay).should.be(DateTime(2022, 12, 31));
    });

    test('Add/sub days', () {
      DateTime(2023)
          .addDays(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 2));
      DateTime(2023).subDays(1).should.be(DateTime(2022, 12, 31));
    });

    test('Add/sub hours', () {
      DateTime(2023)
          .addHours(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 1, 1));
      DateTime(2023, 1, 1, 1).subHours(1).should.be(DateTime(2023));
    });

    test('Add/sub minutes', () {
      DateTime(2023)
          .addMinutes(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 1, 0, 1));
      DateTime(2023, 1, 1, 0, 1).subMinutes(1).should.be(DateTime(2023));
    });

    test('Add/sub seconds', () {
      DateTime(2023)
          .addSeconds(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 1, 0, 0, 1));
      DateTime(2023, 1, 1, 0, 0, 1).subSeconds(1).should.be(DateTime(2023));
    });

    test('Add/sub milliseconds', () {
      DateTime(2023)
          .addMilliseconds(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 1, 0, 0, 0, 1));
      DateTime(2023, 1, 1, 0, 0, 0, 1)
          .subMilliseconds(1)
          .should
          .be(DateTime(2023));
    });

    test('Add/sub microseconds', () {
      DateTime(2023)
          .addMicroseconds(1, ignoreDaylightSavings: true)
          .should
          .be(DateTime(2023, 1, 1, 0, 0, 0, 0, 1));
      DateTime(2023, 1, 1, 0, 0, 0, 0, 1)
          .subMicroseconds(1)
          .should
          .be(DateTime(2023));
    });

    test('Add/sub months', () {
      DateTime(2023).addMonths(1).should.be(DateTime(2023, 2));
      DateTime(2023, 2).subMonths(1).should.be(DateTime(2023));
    });

    test('Add/sub quarters', () {
      DateTime(2023).addQuarters(1).should.be(DateTime(2023, 4));
      DateTime(2023, 4).subQuarters(1).should.be(DateTime(2023));
    });

    test('Add/sub weeks', () {
      DateTime(2023).addWeeks(1).should.be(DateTime(2023, 1, 8));
      DateTime(2023, 1, 8).subWeeks(1).should.be(DateTime(2023));
    });

    test('Add/sub years', () {
      DateTime(2023).addYears(1).should.be(DateTime(2024));
      DateTime(2023).subYears(1).should.be(DateTime(2022));
    });
  });

  group('DateTime copyWith', () {
    final datetime = DateTime(2023);
    test('copy all by 1s', () {
      datetime
          .copyWith(
            year: 2022,
            month: 1,
            day: 1,
            hour: 1,
            minute: 1,
            second: 1,
            millisecond: 1,
            microsecond: 1,
          )
          .should
          .be(DateTime(2022, 1, 1, 1, 1, 1, 1, 1));
    });

    test('copy all by 1s in utc time', () {
      DateTime.utc(2023)
          .copyWith(
            year: 2022,
            month: 1,
            day: 1,
            hour: 1,
            minute: 1,
            second: 1,
            millisecond: 1,
            microsecond: 1,
          )
          .should
          .be(DateTime.utc(2022, 1, 1, 1, 1, 1, 1, 1));
    });
  });

  group('convenience methods', () {
    final start = DateTime(2023);
    final end = DateTime(2023, 1, 10);
    final outsideRange = DateTime(2023, 1, 11);

    test('get week', () {
      start.week.should
          .be(Week(startOfWeek: const Date(year: 2023).startOfWeek));
    });

    test('isWithin', () {
      start.isWithin(DateTimeRange(start: start, end: end)).should.be(true);
      outsideRange
          .isWithin(DateTimeRange(start: start, end: end))
          .should
          .be(false);
    });

    test('isOutside', () {
      start.isOutside(DateTimeRange(start: start, end: end)).should.be(false);
      outsideRange
          .isOutside(DateTimeRange(start: start, end: end))
          .should
          .be(true);
    });

    test('isWithinRange', () {
      start.isWithinRange(start, end).should.be(true);
      outsideRange.isWithinRange(start, end).should.be(false);
    });

    test('isOutsideRange', () {
      start.isOutsideRange(start, end).should.be(false);
      outsideRange.isOutsideRange(start, end).should.be(true);
    });

    test('isEqual', () {
      start.isEqual(DateTime(2023)).should.be(true);
      start.isEqual(end).should.be(false);
    });

    test('comparison operators', () {
      (start < end).should.be(true);
      (start > end).should.be(false);
      (start >= end).should.be(false);
      (start >= end).should.be(false);
    });
  });

  group('Formatter', () {
    // Not necessary since part of dart core but added for complete coverage
    test('with formatter', () {
      DateTime(2023, 2, 21, 6)
          .format('yyyy-MM-dd HH:mm')
          .should
          .be('2023-02-21 06:00');
    });
  });
}
