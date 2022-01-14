// ignore_for_file: avoid_redundant_argument_values

import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  given('Date', () {
    final today = Date.today();
    final tomorrow = Date.tomorrow();

    then('Today is before tomorrow', () {
      (today < tomorrow).should.beTrue();
      (today <= tomorrow).should.beTrue();
    });

    then('Tomorrow is after tomorrow', () {
      (tomorrow > today).should.beTrue();
      (tomorrow >= today).should.beTrue();
    });

    then('Today is today', () {
      (today >= Date.today()).should.beTrue();
    });

    then('Tomorrow is tomorrow', () {
      (Date.tomorrow() == today.nextDay).should.beTrue();
    });

    then('Yesterday is yesterday', () {
      (Date.yesterday() == today.subtract(const Duration(days: 1)))
          .should
          .beTrue();
    });

    then('Future', () {
      (today.addDays(1).isFuture).should.beTrue();
    });

    then('Past', () {
      (today.subDays(1).isPast).should.beTrue();
    });
  });

  given('Weekday test', () {
    const monday = Date(year: 2022, day: 3);

    then('Is Monday', () {
      (monday.isMonday).should.beTrue();
    });

    then('Is Tuesday', () {
      (monday.addDays(1).isTuesday).should.beTrue();
    });

    then('Is Wednesday', () {
      (monday.addDays(2).isWednesday).should.beTrue();
    });

    then('Is Thursday', () {
      (monday.addDays(3).isThursday).should.beTrue();
    });

    then('Is Friday', () {
      (monday.addDays(4).isFriday).should.beTrue();
    });

    then('Is Saturday', () {
      (monday.addDays(5).isSaturday).should.beTrue();
    });

    then('Is Sunday', () {
      (monday.addDays(6).isSunday).should.beTrue();
    });
  });

  given('Leap', () {
    then('2020 is leap year', () {
      const Date(year: 2020).isLeapYear.should.beTrue();
    });

    then('2021 is not leap year', () {
      const Date(year: 2021).isLeapYear.should.beFalse();
    });
  });

  given('Same', () {
    final today = Date.today();
    const date1 = Date(year: 2022, day: 1);
    const date2 = Date(year: 2022, day: 2);
    const date3 = Date(year: 2022, day: 3);
    const date4 = Date(year: 2022, day: 7);
    const date5 = Date(year: 2022, month: 2, day: 15);
    const date6 = Date(year: 2022, month: 12, day: 15);

    then('isLastDay of month', () {
      const Date(year: 2021, day: 31).isLastDayOfMonth.should.beTrue();
    });

    then('isFirstDay of month', () {
      const Date(year: 2021).isFirstDayOfMonth.should.beTrue();
    });

    then('is weekend', () {
      const Date(year: 2022).isWeekend.should.beTrue();
      const Date(year: 2022, day: 2).isWeekend.should.beTrue();
      const Date(year: 2022, day: 3).isWeekend.should.beFalse();
    });

    then('is same week', () {
      date2.isSameWeek(date3).should.beTrue();
    });

    then('is not same week', () {
      date1.isSameWeek(date2).should.beFalse();
    });

    then('is same ISO week', () {
      date1.isSameISOWeek(date2).should.beTrue();
    });

    then('is not same ISO week', () {
      date2.isSameISOWeek(date3).should.beFalse();
    });

    then('is same month', () {
      date1.isSameMonth(date4).should.beTrue();
    });

    then('is same quarter', () {
      date1.isSameQuarter(date5).should.beTrue();
    });

    then('is same year', () {
      date1.isSameYear(date6).should.beTrue();
    });

    then('is this week', () {
      if (today.weekday == DateTime.sunday) {
        today.subDays(1).isThisIsoWeek.should.beTrue();
      } else {
        today.addDays(1).isThisIsoWeek.should.beTrue();
      }

      if (today.weekday == DateTime.saturday) {
        today.subDays(1).isThisWeek.should.beTrue();
      } else {
        today.addDays(1).isThisWeek.should.beTrue();
      }
    });

    then('is this month', () {
      if (today.day < 15) {
        today.addDays(5).isThisMonth.should.beTrue();
      } else {
        today.subDays(5).isThisMonth.should.beTrue();
      }
    });

    then('is this quarter', () {
      if (today.endOfQuarter.month == today.month) {
        today.subMonths(1).isThisQuarter.should.beTrue();
      } else {
        today.addMonths(1).isThisQuarter.should.beTrue();
      }
    });

    then('is this year', () {
      if (today.month == DateTime.december) {
        today.subMonths(1).isThisYear.should.beTrue();
      } else {
        today.addMonths(1).isThisYear.should.beTrue();
      }
    });

    then('is Tomorrow', () {
      today.addDays(1).isTomorrow.should.beTrue();
    });

    then('is Yesterday', () {
      today.subDays(1).isYesterday.should.beTrue();
    });

    then('same hash', () {
      (DateTime(2021).date.hashCode == const Date(year: 2021).hashCode)
          .should
          .beTrue();
    });

    then('same toString', () {
      (DateTime(2021).date.toString() == const Date(year: 2021).toString())
          .should
          .beTrue();
    });
  });

  given('DateTime', () {
    final dateTime = DateTime(2020, 11, 30, 14, 33, 17);

    then('date should be equal to', () {
      dateTime.date.should.be(const Date(year: 2020, month: 11, day: 30));
    });

    then('time should be equal to', () {
      dateTime.time.should.be(const Time(hour: 14, minute: 33, second: 17));
    });

    when('Compare with time greate', () {
      final dateTimeAfter = dateTime.add(const Duration(hours: 24));

      then('second time should be after', () {
        dateTimeAfter.date.isAfter(dateTime.date).should.beTrue();
      });
    });

    when('Compare with the same', () {
      final dateTimeAfter =
          Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);

      then('second time should be the same', () {
        dateTime.date.isAfter(dateTimeAfter).should.not.beTrue();
        dateTimeAfter.isAfter(dateTime.date).should.not.beTrue();
        (dateTimeAfter == dateTime.date).should.beTrue();
      });
    });
  });

  given('Today dateTime', () {
    final today = DateTime.now();

    then('Date should be today', () {
      today.date.isToday.should.beTrue();
    });

    when('add 24 hours', () {
      final nextDay = const Date(year: 2021).add(const Duration(hours: 24));
      then('next day', () {
        nextDay.year.should.be(2021);
        nextDay.month.should.be(1);
        nextDay.day.should.be(2);
      });
    });
  });

  given('dateTime in Friday', () {
    final dateTime = DateTime(2021, 10, 29);

    then('Date should be today', () {
      dateTime.date.weekday.should.be(5);
    });

    when('without separator', () {
      then('should be yyyyMMdd', () {
        dateTime.date.withoutSeparator.should.be('20211029');
      });
    });

    when('with custom separator', () {
      then('should be with yyyy/MM/dd', () {
        dateTime.date.withSeparator('/').should.be('2021/10/29');
      });
    });
  });

  given('Date add', () {
    const date = Date(year: 2021, month: 4);

    then('add 1 day', () {
      final res = date.addDays(1);

      res.day.should.be(2);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('next day', () {
      final res = date.nextDay;

      res.day.should.be(2);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('minus 1 day', () {
      final res = date.addDays(-1);

      res.day.should.be(31);
      res.month.should.be(3);
      res.year.should.be(2021);
    });

    then('previous day', () {
      final res = date.previousDay;

      res.day.should.be(31);
      res.month.should.be(3);
      res.year.should.be(2021);
    });

    then('Add 2 days', () {
      final res = date.addDays(2);

      res.day.should.be(3);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('Add 2 weeks', () {
      final res = date.addWeeks(2);

      res.day.should.be(15);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('Prev week', () {
      final res = date.previousWeek;

      res.day.should.be(25);
      res.month.should.be(3);
      res.year.should.be(2021);
    });

    then('Next week', () {
      final res = date.nextWeek;

      res.day.should.be(8);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('Add 2 months', () {
      final res = date.addMonths(2);

      res.day.should.be(1);
      res.month.should.be(6);
      res.year.should.be(2021);
    });

    then('Add 1 months to end of month', () {
      final res = const Date(year: 2021, month: 10, day: 31).addMonths(1);

      res.day.should.be(1);
      res.month.should.be(12);
      res.year.should.be(2021);
    });

    then('Next month', () {
      final res = date.nextMonth;

      res.day.should.be(1);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('Sub 5 months', () {
      final res = date.subMonths(5);

      res.day.should.be(1);
      res.month.should.be(11);
      res.year.should.be(2020);
    });

    then('Prev month', () {
      final res = date.previousMonth;

      res.day.should.be(1);
      res.month.should.be(3);
      res.year.should.be(2021);
    });

    then('Add 10 months year overflow', () {
      final res = date.addMonths(10);

      res.day.should.be(1);
      res.month.should.be(2);
      res.year.should.be(2022);
    });

    then('Add 2 years', () {
      final res = date.addYears(2);

      res.day.should.be(1);
      res.month.should.be(4);
      res.year.should.be(2023);
    });

    then('Next year', () {
      final res = date.nextYear;

      res.day.should.be(1);
      res.month.should.be(4);
      res.year.should.be(2022);
    });

    then('Sub 1 years', () {
      final res = date.subYears(1);

      res.day.should.be(1);
      res.month.should.be(4);
      res.year.should.be(2020);
    });

    then('Prev year', () {
      final res = date.previousYear;

      res.day.should.be(1);
      res.month.should.be(4);
      res.year.should.be(2020);
    });

    then('Add 60 days', () {
      final res = date.addDays(60);

      res.day.should.be(31);
      res.month.should.be(5);
      res.year.should.be(2021);
    });
  });

  given('Quarters', () {
    const date1 = Date(year: 2021, month: 2, day: 15);
    const date2 = Date(year: 2021, month: 4, day: 2);
    const date3 = Date(year: 2021, month: 9, day: 30);
    const date4 = Date(year: 2021, month: 12, day: 31);

    then('Quarters', () {
      date1.quarter.should.be(1);
      date2.quarter.should.be(2);
      date3.quarter.should.be(3);
      date4.quarter.should.be(4);
    });

    then('Quarter bounds', () {
      date1.startOfQuarter.should.be(const Date(year: 2021));
      date1.endOfQuarter.should.be(const Date(year: 2021, month: 3, day: 31));

      date2.startOfQuarter.should.be(const Date(year: 2021, month: 4, day: 1));
      date2.endOfQuarter.should.be(const Date(year: 2021, month: 6, day: 30));

      date3.startOfQuarter.should.be(const Date(year: 2021, month: 7, day: 1));
      date3.endOfQuarter.should.be(const Date(year: 2021, month: 9, day: 30));

      date4.startOfQuarter.should.be(const Date(year: 2021, month: 10, day: 1));
      date4.endOfQuarter.should.be(const Date(year: 2021, month: 12, day: 31));
    });

    then('Quarter operations', () {
      date1.addQuarters(1).quarter.should.be(2);
      date1.addQuarters(3).quarter.should.be(4);
      date1.addQuarters(4).quarter.should.be(1);

      date1
          .addQuarters(3)
          .should
          .be(const Date(year: 2021, month: 11, day: 15));
      date1.addQuarters(4).should.be(const Date(year: 2022, month: 2, day: 15));

      date1
          .subQuarters(1)
          .should
          .be(const Date(year: 2020, month: 11, day: 15));
    });
  });

  given('Date', () {
    const date = Date(year: 2021, month: 5, day: 15);

    then('Start of year', () {
      final res = date.startOfYear;

      res.day.should.be(1);
      res.month.should.be(1);
      res.year.should.be(2021);
    });

    then('Start of quarter', () {
      final res = date.startOfQuarter;

      res.day.should.be(1);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('Start of month', () {
      final res = date.startOfMonth;

      res.day.should.be(1);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('Start of week', () {
      final res = date.startOfWeek;

      res.day.should.be(9);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('Start of ISO week', () {
      final res = date.startOfISOWeek;

      res.day.should.be(10);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('Start of weekend', () {
      final res = date.startOfWeekend;

      res.day.should.be(15);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('End of year', () {
      final res = date.endOfYear;

      res.day.should.be(31);
      res.month.should.be(12);
      res.year.should.be(2021);
    });

    then('End of quarter', () {
      final res = date.endOfQuarter;

      res.day.should.be(30);
      res.month.should.be(6);
      res.year.should.be(2021);
    });

    then('End of month', () {
      final res = date.endOfMonth;

      res.day.should.be(31);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('End of week', () {
      final res = date.endOfWeek;

      res.day.should.be(15);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('End of ISO week', () {
      final res = date.endOfISOWeek;

      res.day.should.be(16);
      res.month.should.be(5);
      res.year.should.be(2021);
    });

    then('Start of weekend', () {
      final res = date.endOfWeekend;

      res.day.should.be(16);
      res.month.should.be(5);
      res.year.should.be(2021);
    });
  });

  given('Date', () {
    const date = Date(year: 2021, month: 4);

    then('add 1 day duration', () {
      final res = date.add(const Duration(hours: 24));

      res.day.should.be(2);
      res.month.should.be(4);
      res.year.should.be(2021);
    });

    then('minus 1 day duration', () {
      final res = date.add(const Duration(hours: -24));

      res.day.should.be(31);
      res.month.should.be(3);
      res.year.should.be(2021);
    });
  });

  given('Week', () {
    then('getWeek', () {
      const Date(year: 2005, month: DateTime.january, day: 2)
          .getWeek
          .should
          .be(1);
    });

    then('getWeekPreviousYear', () {
      const Date(year: 2005, month: DateTime.january).getWeek.should.be(53);
    });

    then('getWeekBefore100AD', () {
      const Date(year: 7, month: DateTime.december, day: 30)
          .getISOWeek
          .should
          .be(52);
    });

    then('getISOWeek', () {
      const Date(year: 2005, month: DateTime.january, day: 3)
          .getISOWeek
          .should
          .be(1);
    });

    then('getISOWeekPreviousYear', () {
      const Date(year: 2005, month: DateTime.january, day: 2)
          .getISOWeek
          .should
          .be(53);
    });

    then('ISOWeek - Week compare', () {
      const Date(year: 1922, month: DateTime.january).getWeek.should.be(1);
      const Date(year: 1922, month: DateTime.january).getISOWeek.should.be(52);
    });
  });

  group('Parsing', () {
    //
    test('w/o formatter', () {
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
        final date = Date.parse(dateStr);
        date.should.be(const Date(year: 2012, month: 2, day: 27));
      }
    });

    test('with formatter', () {
      const format = "MMMM dd, yyyy 'at' hh:mm:ss a Z";
      final date =
          Date.parse('August 6, 2020 at 5:44:45 PM UTC+7', format: format);
      date.should.be(const Date(year: 2020, month: 8, day: 6));
    });

    test('try parse invalid date w/o formatter', () {
      final date = Date.tryParse('12/31/2021');
      date.should.beNull();
    });

    test('try parse with format', () {
      final date = Date.tryParse('12/31/2021', format: 'MM/dd/yyyy');
      date.should.be(const Date(year: 2021, month: 12, day: 31));
    });
  });

  test('now()', () {
    final dateTime = DateTime.now();
    final date = Date.now();

    date.day.should.be(dateTime.day);
    date.month.should.be(dateTime.month);
    date.year.should.be(dateTime.year);
    date.should.be(dateTime.date);
  });

  test('nowUtc()', () {
    final dateTime = DateTime.now().toUtc();
    final date = Date.nowUtc();

    date.day.should.be(dateTime.day);
    date.month.should.be(dateTime.month);
    date.year.should.be(dateTime.year);
    date.should.be(dateTime.date);
  });
}
