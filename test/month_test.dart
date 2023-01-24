// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  final now = Month.now();
  final thisMonth = Month.thisMonth();
  final lastMonth = Month.lastMonth();
  final nextMonth = Month.nextMonth();
  const janOnNormalYear = Month(year: 2023); //2023 is a normal year
  const janOnLeapYear = Month(year: 2024); // 2024 is a leap year
  const febOnNormalYear = Month(year: 2023, month: 2);
  const febOnLeapYear = Month(year: 2024, month: 2);
  const march = Month(year: 2023, month: 3);
  const april = Month(year: 2023, month: 4);
  const may = Month(year: 2023, month: 5);
  const june = Month(year: 2023, month: 6);
  const july = Month(year: 2023, month: 7);
  const august = Month(year: 2023, month: 8);
  const september = Month(year: 2023, month: 9);
  const october = Month(year: 2023, month: 10);
  const november = Month(year: 2023, month: 11);
  const december = Month(year: 2023, month: 12);

  group('Testing month comparison methods', () {
    test('Compare this month and itself (now)', () {
      (thisMonth == now).should.beTrue();
      (thisMonth > now).should.beFalse();
      (thisMonth >= now).should.beTrue();
      (thisMonth < now).should.beFalse();
      (thisMonth <= now).should.beTrue();

      thisMonth.isAfter(now).should.beFalse();
      thisMonth.isSameOrAfter(now).should.beTrue();
      thisMonth.isBefore(now).should.beFalse();
      thisMonth.isSameOrBefore(now).should.beTrue();
    });

    test('Compare this month and next month', () {
      (thisMonth == nextMonth).should.beFalse();
      (thisMonth > nextMonth).should.beFalse();
      (thisMonth >= nextMonth).should.beFalse();
      (thisMonth < nextMonth).should.beTrue();
      (thisMonth <= nextMonth).should.beTrue();

      thisMonth.isAfter(nextMonth).should.beFalse();
      thisMonth.isSameOrAfter(nextMonth).should.beFalse();
      thisMonth.isBefore(nextMonth).should.beTrue();
      thisMonth.isSameOrBefore(nextMonth).should.beTrue();
    });

    test('Compare this month and last month', () {
      (thisMonth == lastMonth).should.beFalse();
      (thisMonth > lastMonth).should.beTrue();
      (thisMonth >= lastMonth).should.beTrue();
      (thisMonth < lastMonth).should.beFalse();
      (thisMonth <= lastMonth).should.beFalse();

      thisMonth.isAfter(lastMonth).should.beTrue();
      thisMonth.isSameOrAfter(lastMonth).should.beTrue();
      thisMonth.isBefore(lastMonth).should.beFalse();
      thisMonth.isSameOrBefore(lastMonth).should.beFalse();
    });

    test('Compare last month and next month', () {
      (lastMonth == nextMonth).should.beFalse();
      (lastMonth > nextMonth).should.beFalse();
      (lastMonth >= nextMonth).should.beFalse();
      (lastMonth < nextMonth).should.beTrue();
      (lastMonth <= nextMonth).should.beTrue();

      thisMonth.isAfter(nextMonth).should.beFalse();
      thisMonth.isSameOrAfter(nextMonth).should.beFalse();
      thisMonth.isBefore(nextMonth).should.beTrue();
      thisMonth.isSameOrBefore(nextMonth).should.beTrue();
    });
  });

  group('Testing start and end of month', () {
    test('Start and end of january', () {
      janOnNormalYear.startOfMonth.should
          .be(Date(year: 2023, month: 1, day: 1));
      janOnNormalYear.endOfMonth.should.be(Date(year: 2023, month: 1, day: 31));
    });

    test('Start and end of february', () {
      febOnNormalYear.startOfMonth.should
          .be(Date(year: 2023, month: 2, day: 1));
      febOnNormalYear.endOfMonth.should.be(Date(year: 2023, month: 2, day: 28));
      febOnLeapYear.startOfMonth.should.be(Date(year: 2024, month: 2, day: 1));
      febOnLeapYear.endOfMonth.should.be(Date(year: 2024, month: 2, day: 29));
    });

    test('Start and end of march', () {
      march.startOfMonth.should.be(Date(year: 2023, month: 3, day: 1));
      march.endOfMonth.should.be(Date(year: 2023, month: 3, day: 31));
    });

    test('Start and end of april', () {
      april.startOfMonth.should.be(Date(year: 2023, month: 4, day: 1));
      april.endOfMonth.should.be(Date(year: 2023, month: 4, day: 30));
    });

    test('Start and end of may', () {
      may.startOfMonth.should.be(Date(year: 2023, month: 5, day: 1));
      may.endOfMonth.should.be(Date(year: 2023, month: 5, day: 31));
    });

    test('Start and end of june', () {
      june.startOfMonth.should.be(Date(year: 2023, month: 6, day: 1));
      june.endOfMonth.should.be(Date(year: 2023, month: 6, day: 30));
    });

    test('Start and end of july', () {
      july.startOfMonth.should.be(Date(year: 2023, month: 7, day: 1));
      july.endOfMonth.should.be(Date(year: 2023, month: 7, day: 31));
    });

    test('Start and end of august', () {
      august.startOfMonth.should.be(Date(year: 2023, month: 8, day: 1));
      august.endOfMonth.should.be(Date(year: 2023, month: 8, day: 31));
    });

    test('Start and end of september', () {
      september.startOfMonth.should.be(Date(year: 2023, month: 9, day: 1));
      september.endOfMonth.should.be(Date(year: 2023, month: 9, day: 30));
    });

    test('Start and end of october', () {
      october.startOfMonth.should.be(Date(year: 2023, month: 10, day: 1));
      october.endOfMonth.should.be(Date(year: 2023, month: 10, day: 31));
    });

    test('Start and end of november', () {
      november.startOfMonth.should.be(Date(year: 2023, month: 11, day: 1));
      november.endOfMonth.should.be(Date(year: 2023, month: 11, day: 30));
    });

    test('Start and end of december', () {
      december.startOfMonth.should.be(Date(year: 2023, month: 12, day: 1));
      december.endOfMonth.should.be(Date(year: 2023, month: 12, day: 31));
    });
  });

  group('Testing month operations', () {
    test('Add/subtract duration operation', () {
      // add normal
      janOnNormalYear
          .add(Duration(days: 1))
          .should
          .be(Month(year: 2023, month: 2));
      janOnNormalYear
          .add(Duration(days: 28))
          .should
          .be(Month(year: 2023, month: 2));
      janOnNormalYear
          .add(Duration(days: 29))
          .should
          .be(Month(year: 2023, month: 3));

      // sub normal
      janOnNormalYear
          .subtract(Duration(days: 1))
          .should
          .be(Month(year: 2022, month: 12));
      janOnNormalYear
          .subtract(Duration(days: 31))
          .should
          .be(Month(year: 2022, month: 12));
      janOnNormalYear
          .subtract(Duration(days: 32))
          .should
          .be(Month(year: 2022, month: 11));

      // add leap
      janOnLeapYear
          .add(Duration(days: 1))
          .should
          .be(Month(year: 2024, month: 2));
      janOnLeapYear
          .add(Duration(days: 29))
          .should
          .be(Month(year: 2024, month: 2));
      janOnLeapYear
          .add(Duration(days: 30))
          .should
          .be(Month(year: 2024, month: 3));
    });

    test('Add/subtract days operation', () {
      // add normal
      janOnNormalYear.addDays(1).should.be(Month(year: 2023, month: 2));
      janOnNormalYear.addDays(28).should.be(Month(year: 2023, month: 2));
      janOnNormalYear.addDays(29).should.be(Month(year: 2023, month: 3));

      // sub normal
      janOnNormalYear.subDays(1).should.be(Month(year: 2022, month: 12));
      janOnNormalYear.subDays(31).should.be(Month(year: 2022, month: 12));
      janOnNormalYear.subDays(32).should.be(Month(year: 2022, month: 11));

      // add leap
      janOnLeapYear.addDays(1).should.be(Month(year: 2024, month: 2));
      janOnLeapYear.addDays(29).should.be(Month(year: 2024, month: 2));
      janOnLeapYear.addDays(30).should.be(Month(year: 2024, month: 3));
    });

    test('Add/subtract weeks operation', () {
      // add
      janOnNormalYear.addWeeks(1).should.be(Month(year: 2023, month: 2));

      // sub
      janOnNormalYear.subWeeks(1).should.be(Month(year: 2022, month: 12));
      janOnNormalYear.subWeeks(5).should.be(Month(year: 2022, month: 11));
    });

    test('Add/subtract months operation', () {
      // add
      janOnNormalYear.addMonths(1).should.be(Month(year: 2023, month: 2));
      janOnNormalYear.addMonths(11).should.be(Month(year: 2023, month: 12));
      janOnNormalYear.addMonths(12).should.be(Month(year: 2024, month: 1));

      // sub
      janOnNormalYear.subMonths(1).should.be(Month(year: 2022, month: 12));
      janOnNormalYear.subMonths(12).should.be(Month(year: 2022, month: 1));
      janOnNormalYear.subMonths(13).should.be(Month(year: 2021, month: 12));
    });

    test('Add/subtract quarters operation', () {
      // add
      janOnNormalYear.addQuarters(1).should.be(Month(year: 2023, month: 4));
      janOnNormalYear.addQuarters(4).should.be(Month(year: 2024, month: 1));

      // sub
      janOnNormalYear.subQuarters(1).should.be(Month(year: 2022, month: 10));
      janOnNormalYear.subQuarters(4).should.be(Month(year: 2022, month: 1));
    });

    test('Add/subtract years operation', () {
      // add
      march.addYears(1).should.be(Month(year: 2024, month: 3));
      march.addYears(4).should.be(Month(year: 2027, month: 3));

      // sub
      march.subYears(1).should.be(Month(year: 2022, month: 3));
      march.subYears(4).should.be(Month(year: 2019, month: 3));
    });
  });

  group('Test parsing', () {
    test('parse without formatter', () {
      final dates = [
        '2012-02-27 13:27:00',
        '2012-02-27 13:27:00.123456z',
        '20120227 13:27:00',
        '20120227T132700',
        '+20120227',
        '2012-02-27T14Z',
        '2012-02-27T14+00:00',
        '2012-02-27T14:00:00-0500',
        '20120227',
        '2012-02-27',
      ];

      for (final dateStr in dates) {
        final month = Month.parse(dateStr);
        month.should.be(const Month(year: 2012, month: 2));
      }
    });

    test('parse with formatter', () {
      const format = "MMMM dd, yyyy 'at' hh:mm:ss a Z";
      final month =
          Month.parse('August 6, 2020 at 5:44:45 PM UTC+7', format: format);
      month.should.be(const Month(year: 2020, month: 8));
    });

    test('try parse invalid date w/o formatter', () {
      final month = Month.tryParse('12/31/2021');
      month.should.beNull();
    });

    test('try parse with format', () {
      final month = Month.tryParse('12/31/2021', format: 'MM/dd/yyyy');
      month.should.be(const Month(year: 2021, month: 12));
    });

    test('format with pattern', () {
      const pattern = 'MMMM dd, yyyy';
      Month(year: 2023, month: 8).format(pattern).should.be('August 01, 2023');
    });

    test('toString', () {
      march.toString().should.be('2023-03');
      december.toString().should.be('2023-12');
      Month.epoch.toString().should.be('1970-01');
      Month.startOfTime.toString().should.be('0001-01');
    });

    test('fromKey', () {
      Month.fromKey('2023-03').should.be(march);
      Month.fromKey('2023-12').should.be(december);
      Month.fromKey('1970-01').should.be(Month.epoch);
      Month.fromKey('0001-01').should.be(Month.startOfTime);
    });
  });

  group('Test MONTH enum', () {
    test('test fromNumber()', () {
      MONTH.fromNumber(1).should.be(MONTH.january);
      MONTH.fromNumber(2).should.be(MONTH.february);
      MONTH.fromNumber(3).should.be(MONTH.march);
      MONTH.fromNumber(4).should.be(MONTH.april);
      MONTH.fromNumber(5).should.be(MONTH.may);
      MONTH.fromNumber(6).should.be(MONTH.june);
      MONTH.fromNumber(7).should.be(MONTH.july);
      MONTH.fromNumber(8).should.be(MONTH.august);
      MONTH.fromNumber(9).should.be(MONTH.september);
      MONTH.fromNumber(10).should.be(MONTH.october);
      MONTH.fromNumber(11).should.be(MONTH.november);
      MONTH.fromNumber(12).should.be(MONTH.december);
    });

    test('test month number', () {
      (janOnNormalYear.month == MONTH.january.number).should.beTrue();
      (febOnNormalYear.month == MONTH.february.number).should.beTrue();
      (march.month == MONTH.march.number).should.beTrue();
      (april.month == MONTH.april.number).should.beTrue();
      (may.month == MONTH.may.number).should.beTrue();
      (june.month == MONTH.june.number).should.beTrue();
      (july.month == MONTH.july.number).should.beTrue();
      (august.month == MONTH.august.number).should.beTrue();
      (september.month == MONTH.september.number).should.beTrue();
      (october.month == MONTH.october.number).should.beTrue();
      (november.month == MONTH.november.number).should.beTrue();
      (december.month == MONTH.december.number).should.beTrue();
    });

    test('test enum value', () {
      (janOnNormalYear.getMONTH == MONTH.january).should.beTrue();
      (febOnNormalYear.getMONTH == MONTH.february).should.beTrue();
      (march.getMONTH == MONTH.march).should.beTrue();
      (april.getMONTH == MONTH.april).should.beTrue();
      (may.getMONTH == MONTH.may).should.beTrue();
      (june.getMONTH == MONTH.june).should.beTrue();
      (july.getMONTH == MONTH.july).should.beTrue();
      (august.getMONTH == MONTH.august).should.beTrue();
      (september.getMONTH == MONTH.september).should.beTrue();
      (october.getMONTH == MONTH.october).should.beTrue();
      (november.getMONTH == MONTH.november).should.beTrue();
      (december.getMONTH == MONTH.december).should.beTrue();
    });

    test('test enum titles in en_US', () {
      MONTH.january.title('en_US').should.be('January');
      MONTH.february.title('en_US').should.be('February');
      MONTH.march.title('en_US').should.be('March');
      MONTH.april.title('en_US').should.be('April');
      MONTH.may.title('en_US').should.be('May');
      MONTH.june.title('en_US').should.be('June');
      MONTH.july.title('en_US').should.be('July');
      MONTH.august.title('en_US').should.be('August');
      MONTH.september.title('en_US').should.be('September');
      MONTH.october.title('en_US').should.be('October');
      MONTH.november.title('en_US').should.be('November');
      MONTH.december.title('en_US').should.be('December');
    });

    test('test enum short titles in en_US', () {
      MONTH.january.shortTitle('en_US').should.be('Jan');
      MONTH.february.shortTitle('en_US').should.be('Feb');
      MONTH.march.shortTitle('en_US').should.be('Mar');
      MONTH.april.shortTitle('en_US').should.be('Apr');
      MONTH.may.shortTitle('en_US').should.be('May');
      MONTH.june.shortTitle('en_US').should.be('Jun');
      MONTH.july.shortTitle('en_US').should.be('Jul');
      MONTH.august.shortTitle('en_US').should.be('Aug');
      MONTH.september.shortTitle('en_US').should.be('Sep');
      MONTH.october.shortTitle('en_US').should.be('Oct');
      MONTH.november.shortTitle('en_US').should.be('Nov');
      MONTH.december.shortTitle('en_US').should.be('Dec');
    });
  });

  group('Test dates in the month', () {
    test('test dates', () {
      janOnNormalYear.dates[1].should.be(Date(year: 2023, month: 1, day: 1));
      janOnNormalYear.dates[31].should.be(Date(year: 2023, month: 1, day: 31));
      janOnNormalYear.dates[0].should.beNull();
      janOnNormalYear.dates[32].should.beNull();

      febOnNormalYear.dates[1].should.be(Date(year: 2023, month: 2, day: 1));
      febOnNormalYear.dates[28].should.be(Date(year: 2023, month: 2, day: 28));
      febOnNormalYear.dates[0].should.beNull();
      febOnNormalYear.dates[29].should.beNull();

      febOnLeapYear.dates[1].should.be(Date(year: 2024, month: 2, day: 1));
      febOnLeapYear.dates[29].should.be(Date(year: 2024, month: 2, day: 29));
      febOnLeapYear.dates[0].should.beNull();
      febOnLeapYear.dates[30].should.beNull();
    });

    test('test [] operator', () {
      janOnNormalYear[1].should.be(Date(year: 2023, month: 1, day: 1));
      janOnNormalYear[31].should.be(Date(year: 2023, month: 1, day: 31));
      expect(() => janOnNormalYear[0], throwsRangeError);
      expect(() => janOnNormalYear[32], throwsRangeError);

      febOnNormalYear[1].should.be(Date(year: 2023, month: 2, day: 1));
      febOnNormalYear[28].should.be(Date(year: 2023, month: 2, day: 28));
      expect(() => febOnNormalYear[0], throwsRangeError);
      expect(() => febOnNormalYear[29], throwsRangeError);

      febOnLeapYear[1].should.be(Date(year: 2024, month: 2, day: 1));
      febOnLeapYear[29].should.be(Date(year: 2024, month: 2, day: 29));
      expect(() => febOnLeapYear[0], throwsRangeError);
      expect(() => febOnLeapYear[30], throwsRangeError);
    });
  });

  group('test copyWith', () {
    const month = Month(year: 2022, month: 5);

    test('year', () {
      month.copyWith(year: 2025).should.be(Month(year: 2025, month: 5));
    });

    test('month', () {
      month.copyWith(month: 9).should.be(Month(year: 2022, month: 9));
    });

    test('setYear', () {
      month.setYear(2025).should.be(Month(year: 2025, month: 5));
    });

    test('setMonth', () {
      month.setMonth(9).should.be(Month(year: 2022, month: 9));
    });

    test('setMONTH', () {
      month.setMONTH(MONTH.september).should.be(Month(year: 2022, month: 9));
    });
  });
}
