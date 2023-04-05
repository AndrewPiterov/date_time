// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  final now = Year.now();
  final thisYear = Year.thisYear();
  final lastYear = Year.lastYear();
  final nextYear = Year.nextYear();
  const normalYear2023 = Year(2023); //2023 is a normal year
  const leapYear2024 = Year(2024); // 2024 is a leap year

  group('Testing year comparison methods', () {
    test('Compare this year and itself (now)', () {
      (thisYear == now).should.beTrue();
      (thisYear > now).should.beFalse();
      (thisYear >= now).should.beTrue();
      (thisYear < now).should.beFalse();
      (thisYear <= now).should.beTrue();

      thisYear.isAfter(now).should.beFalse();
      thisYear.isSameOrAfter(now).should.beTrue();
      thisYear.isBefore(now).should.beFalse();
      thisYear.isSameOrBefore(now).should.beTrue();
    });

    test('Compare this year and next year', () {
      (thisYear == nextYear).should.beFalse();
      (thisYear > nextYear).should.beFalse();
      (thisYear >= nextYear).should.beFalse();
      (thisYear < nextYear).should.beTrue();
      (thisYear <= nextYear).should.beTrue();

      thisYear.isAfter(nextYear).should.beFalse();
      thisYear.isSameOrAfter(nextYear).should.beFalse();
      thisYear.isBefore(nextYear).should.beTrue();
      thisYear.isSameOrBefore(nextYear).should.beTrue();
    });

    test('Compare this year and last year', () {
      (thisYear == lastYear).should.beFalse();
      (thisYear > lastYear).should.beTrue();
      (thisYear >= lastYear).should.beTrue();
      (thisYear < lastYear).should.beFalse();
      (thisYear <= lastYear).should.beFalse();

      thisYear.isAfter(lastYear).should.beTrue();
      thisYear.isSameOrAfter(lastYear).should.beTrue();
      thisYear.isBefore(lastYear).should.beFalse();
      thisYear.isSameOrBefore(lastYear).should.beFalse();
    });

    test('Compare last year and next year', () {
      (lastYear == nextYear).should.beFalse();
      (lastYear > nextYear).should.beFalse();
      (lastYear >= nextYear).should.beFalse();
      (lastYear < nextYear).should.beTrue();
      (lastYear <= nextYear).should.beTrue();

      thisYear.isAfter(nextYear).should.beFalse();
      thisYear.isSameOrAfter(nextYear).should.beFalse();
      thisYear.isBefore(nextYear).should.beTrue();
      thisYear.isSameOrBefore(nextYear).should.beTrue();
    });

    test('Test bool for this, last and next year', () {
      lastYear.isLastYear.should.beTrue();
      lastYear.isThisYear.should.beFalse();
      lastYear.isNextYear.should.beFalse();

      thisYear.isLastYear.should.beFalse();
      thisYear.isThisYear.should.beTrue();
      thisYear.isNextYear.should.beFalse();

      nextYear.isLastYear.should.beFalse();
      nextYear.isThisYear.should.beFalse();
      nextYear.isNextYear.should.beTrue();
    });
  });

  group('Testing start and end of year', () {
    test('Start and end of year (2023)', () {
      normalYear2023.startOfYear.should.be(Date(year: 2023, month: 1, day: 1));
      normalYear2023.endOfYear.should.be(Date(year: 2023, month: 12, day: 31));
      normalYear2023.firstWeek.should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 1)));
      normalYear2023.lastWeek.should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 24)));
      normalYear2023.firstISOWeek.should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 2)));
      normalYear2023.lastISOWeek.should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 25)));
    });

    test('Start and end of year (2024)', () {
      leapYear2024.startOfYear.should.be(Date(year: 2024, month: 1, day: 1));
      leapYear2024.endOfYear.should.be(Date(year: 2024, month: 12, day: 31));
      leapYear2024.firstWeek.should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 31)));
      leapYear2024.lastWeek.should
          .be(Week(startOfWeek: Date(year: 2024, month: 12, day: 22)));
      leapYear2024.firstISOWeek.should
          .be(Week(startOfWeek: Date(year: 2024, month: 1, day: 1)));
      leapYear2024.lastISOWeek.should
          .be(Week(startOfWeek: Date(year: 2024, month: 12, day: 23)));
    });
  });

  group('Testing year operations', () {
    test('Add/subtract duration operation', () {
      // add
      normalYear2023.add(Duration(days: 1)).should.be(Year(2024));
      normalYear2023.add(Duration(days: 366)).should.be(Year(2024));
      normalYear2023.add(Duration(days: 367)).should.be(Year(2025));

      // sub
      normalYear2023.subtract(Duration(days: 1)).should.be(Year(2022));
    });

    test('Add/subtract days operation', () {
      // add
      normalYear2023.addDays(1).should.be(Year(2024));
      normalYear2023.addDays(366).should.be(Year(2024));
      normalYear2023.addDays(367).should.be(Year(2025));

      // sub
      normalYear2023.subDays(1).should.be(Year(2022));
    });

    test('Add/subtract weeks operation', () {
      // add
      normalYear2023.addWeeks(1).should.be(Year(2024));
      normalYear2023.addWeeks(52).should.be(Year(2024));
      normalYear2023.addWeeks(53).should.be(Year(2025));

      // sub
      normalYear2023.subWeeks(1).should.be(Year(2022));
      normalYear2023.subWeeks(52).should.be(Year(2022));
      normalYear2023.subWeeks(53).should.be(Year(2021));
    });

    test('Add/subtract months operation', () {
      // add
      normalYear2023.addMonths(1).should.be(Year(2024));
      normalYear2023.addMonths(12).should.be(Year(2024));
      normalYear2023.addMonths(13).should.be(Year(2025));

      // sub
      normalYear2023.subMonths(1).should.be(Year(2022));
      normalYear2023.subMonths(12).should.be(Year(2022));
      normalYear2023.subMonths(13).should.be(Year(2021));
    });

    test('Add/subtract quarters operation', () {
      // add
      normalYear2023.addQuarters(1).should.be(Year(2024));
      normalYear2023.addQuarters(4).should.be(Year(2024));
      normalYear2023.addQuarters(5).should.be(Year(2025));

      // sub
      normalYear2023.subQuarters(1).should.be(Year(2022));
      normalYear2023.subQuarters(4).should.be(Year(2022));
      normalYear2023.subQuarters(5).should.be(Year(2021));
    });

    test('Add/subtract years operation', () {
      // add
      normalYear2023.addYears(1).should.be(Year(2024));

      // sub
      normalYear2023.subYears(1).should.be(Year(2022));
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
        final year = Year.parse(dateStr);
        year.should.be(const Year(2012));
      }
    });

    test('parse with formatter', () {
      const format = "MMMM dd, yyyy 'at' hh:mm:ss a Z";
      final year =
          Year.parse('August 6, 2020 at 5:44:45 PM UTC+7', format: format);
      year.should.be(const Year(2020));
    });

    test('try parse invalid date w/o formatter', () {
      final year = Year.tryParse('12/31/2021');
      year.should.beNull();
    });

    test('try parse with format', () {
      final year = Year.tryParse('12/31/2021', format: 'MM/dd/yyyy');
      year.should.be(const Year(2021));
    });

    test('format with pattern', () {
      const pattern = 'MMMM dd, yyyy';
      Year(2023).format(pattern).should.be('January 01, 2023');
    });

    test('toString', () {
      normalYear2023.toString().should.be('2023');
      leapYear2024.toString().should.be('2024');
      Year.epoch.toString().should.be('1970');
      Year.startOfTime.toString().should.be('0001');
    });

    test('fromKey', () {
      Year.fromKey('2023').should.be(normalYear2023);
      Year.fromKey('2024').should.be(leapYear2024);
      Year.fromKey('1970').should.be(Year.epoch);
      Year.fromKey('0001').should.be(Year.startOfTime);
    });
  });

  group('test dates, weeks and months', () {
    test('dates', () {
      normalYear2023.dates.length.should.be(365);
      normalYear2023.dates[1].should.be(Date(year: 2023, month: 1, day: 1));
      normalYear2023.dates[365].should.be(Date(year: 2023, month: 12, day: 31));
      normalYear2023.dates[366].should.beNull();

      leapYear2024.dates.length.should.be(366);
      leapYear2024.dates[1].should.be(Date(year: 2024, month: 1, day: 1));
      leapYear2024.dates[366].should.be(Date(year: 2024, month: 12, day: 31));
      leapYear2024.dates[367].should.beNull();
    });

    test('weeks', () {
      normalYear2023.weeks.length.should.be(52);
      normalYear2023.weeks[1].should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 1)));
      normalYear2023.weeks[52].should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 24)));
    });

    test('iso weeks', () {
      normalYear2023.isoWeeks.length.should.be(52);
      normalYear2023.isoWeeks[1].should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 2)));
      normalYear2023.isoWeeks[52].should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 25)));
    });

    test('months', () {
      normalYear2023.months.length.should.be(12);
      normalYear2023.months[MONTH.january].should
          .be(Month(year: 2023, month: 1));
      normalYear2023.months[MONTH.february].should
          .be(Month(year: 2023, month: 2));
      normalYear2023.months[MONTH.march].should.be(Month(year: 2023, month: 3));
      normalYear2023.months[MONTH.april].should.be(Month(year: 2023, month: 4));
      normalYear2023.months[MONTH.may].should.be(Month(year: 2023, month: 5));
      normalYear2023.months[MONTH.june].should.be(Month(year: 2023, month: 6));
      normalYear2023.months[MONTH.july].should.be(Month(year: 2023, month: 7));
      normalYear2023.months[MONTH.august].should
          .be(Month(year: 2023, month: 8));
      normalYear2023.months[MONTH.september].should
          .be(Month(year: 2023, month: 9));
      normalYear2023.months[MONTH.october].should
          .be(Month(year: 2023, month: 10));
      normalYear2023.months[MONTH.november].should
          .be(Month(year: 2023, month: 11));
      normalYear2023.months[MONTH.december].should
          .be(Month(year: 2023, month: 12));

      normalYear2023.january.should.be(Month(year: 2023, month: 1));
      normalYear2023.february.should.be(Month(year: 2023, month: 2));
      normalYear2023.march.should.be(Month(year: 2023, month: 3));
      normalYear2023.april.should.be(Month(year: 2023, month: 4));
      normalYear2023.may.should.be(Month(year: 2023, month: 5));
      normalYear2023.june.should.be(Month(year: 2023, month: 6));
      normalYear2023.july.should.be(Month(year: 2023, month: 7));
      normalYear2023.august.should.be(Month(year: 2023, month: 8));
      normalYear2023.september.should.be(Month(year: 2023, month: 9));
      normalYear2023.october.should.be(Month(year: 2023, month: 10));
      normalYear2023.november.should.be(Month(year: 2023, month: 11));
      normalYear2023.december.should.be(Month(year: 2023, month: 12));
    });
  });

  group('test copyWith', () {
    const year = Year(2022);

    test('year', () {
      year.copyWith(year: 2025).should.be(Year(2025));
    });

    test('setYear', () {
      year.setYear(2025).should.be(Year(2025));
    });
  });
}
