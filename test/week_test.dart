// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors

import 'package:date_time/date_time.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  initializeDateFormatting();
  final now = Week.now();
  final thisWeek = Week.thisWeek();
  final lastWeek = Week.lastWeek();
  final nextWeek = Week.nextWeek();
  final isoFirstWeekOf2023 = Year(2023).firstISOWeek;
  final isoLastWeekOf2023 = Year(2023).lastISOWeek;
  final firstWeekOf2023 = Year(2023).firstWeek;
  final lastWeekOf2023 = Year(2023).lastWeek;
  final sunday1 = Date(year: 2023, month: 1, day: 1);
  final monday = Date(year: 2023, month: 1, day: 2);
  final tuesday = Date(year: 2023, month: 1, day: 3);
  final wednesday = Date(year: 2023, month: 1, day: 4);
  final thursday = Date(year: 2023, month: 1, day: 5);
  final friday = Date(year: 2023, month: 1, day: 6);
  final saturday = Date(year: 2023, month: 1, day: 7);
  final sunday2 = Date(year: 2023, month: 1, day: 8);

  group('Testing week comparison methods', () {
    test('equals', () {
      (thisWeek == Week.thisWeek()).should.beTrue();
      (lastWeek == Week.lastWeek()).should.beTrue();
      (nextWeek == Week.nextWeek()).should.beTrue();
      (thisWeek == nextWeek).should.beFalse();
      (thisWeek.hashCode == nextWeek.hashCode).should.beFalse();
      (thisWeek != nextWeek).should.beTrue();
      (thisWeek.hashCode != nextWeek.hashCode).should.beTrue();
    });

    test('Compare this week and itself (now)', () {
      (thisWeek == now).should.beTrue();
      (thisWeek > now).should.beFalse();
      (thisWeek >= now).should.beTrue();
      (thisWeek < now).should.beFalse();
      (thisWeek <= now).should.beTrue();

      thisWeek.isAfter(now).should.beFalse();
      thisWeek.isSameOrAfter(now).should.beTrue();
      thisWeek.isBefore(now).should.beFalse();
      thisWeek.isSameOrBefore(now).should.beTrue();
    });

    test('Compare this week and next week', () {
      (thisWeek == nextWeek).should.beFalse();
      (thisWeek > nextWeek).should.beFalse();
      (thisWeek >= nextWeek).should.beFalse();
      (thisWeek < nextWeek).should.beTrue();
      (thisWeek <= nextWeek).should.beTrue();

      thisWeek.isAfter(nextWeek).should.beFalse();
      thisWeek.isSameOrAfter(nextWeek).should.beFalse();
      thisWeek.isBefore(nextWeek).should.beTrue();
      thisWeek.isSameOrBefore(nextWeek).should.beTrue();
    });

    test('Compare this week and last week', () {
      // lastWeek.should.be('lastWeek');
      // thisWeek.should.be('thisWeek');
      // nextWeek.should.be('nextWeek');
      (thisWeek == lastWeek).should.beFalse();
      (thisWeek > lastWeek).should.beTrue();
      (thisWeek >= lastWeek).should.beTrue();
      (thisWeek < lastWeek).should.beFalse();
      (thisWeek <= lastWeek).should.beFalse();

      thisWeek.isAfter(lastWeek).should.beTrue();
      thisWeek.isSameOrAfter(lastWeek).should.beTrue();
      thisWeek.isBefore(lastWeek).should.beFalse();
      thisWeek.isSameOrBefore(lastWeek).should.beFalse();
    });

    test('Compare last week and next week', () {
      (lastWeek == nextWeek).should.beFalse();
      (lastWeek > nextWeek).should.beFalse();
      (lastWeek >= nextWeek).should.beFalse();
      (lastWeek < nextWeek).should.beTrue();
      (lastWeek <= nextWeek).should.beTrue();

      thisWeek.isAfter(nextWeek).should.beFalse();
      thisWeek.isSameOrAfter(nextWeek).should.beFalse();
      thisWeek.isBefore(nextWeek).should.beTrue();
      thisWeek.isSameOrBefore(nextWeek).should.beTrue();
    });

    test('boolean flags', () {
      lastWeek.isThisWeek.should.beFalse();
      lastWeek.isLastWeek.should.beTrue();
      lastWeek.isNextWeek.should.beFalse();

      thisWeek.isThisWeek.should.beTrue();
      thisWeek.isLastWeek.should.beFalse();
      thisWeek.isNextWeek.should.beFalse();

      nextWeek.isThisWeek.should.beFalse();
      nextWeek.isLastWeek.should.beFalse();
      nextWeek.isNextWeek.should.beTrue();
    });
  });

  group('Testing start and end of week', () {
    test('Start and end of week of 2023', () {
      firstWeekOf2023.startOfWeek.should.be(Date(year: 2023, month: 1, day: 1));
      firstWeekOf2023.endOfWeek.should.be(Date(year: 2023, month: 1, day: 7));
      isoFirstWeekOf2023.startOfWeek.should
          .be(Date(year: 2023, month: 1, day: 2));
      isoFirstWeekOf2023.endOfWeek.should
          .be(Date(year: 2023, month: 1, day: 8));

      lastWeekOf2023.startOfWeek.should
          .be(Date(year: 2023, month: 12, day: 24));
      lastWeekOf2023.endOfWeek.should.be(Date(year: 2023, month: 12, day: 30));
      isoLastWeekOf2023.startOfWeek.should
          .be(Date(year: 2023, month: 12, day: 25));
      isoLastWeekOf2023.endOfWeek.should
          .be(Date(year: 2023, month: 12, day: 31));
    });
  });

  group('Testing week operations', () {
    test('Add/subtract weeks operation', () {
      // iso
      isoFirstWeekOf2023
          .addWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 9)));
      isoFirstWeekOf2023
          .subWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2022, month: 12, day: 26)));
      isoLastWeekOf2023
          .addWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2024, month: 1, day: 1)));
      isoLastWeekOf2023
          .subWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 18)));

      // non iso
      firstWeekOf2023
          .addWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 1, day: 8)));
      firstWeekOf2023
          .subWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2022, month: 12, day: 25)));
      lastWeekOf2023
          .addWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 31)));
      lastWeekOf2023
          .subWeeks(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 17)));
    });

    test('Add/subtract years operation', () {
      // iso
      isoFirstWeekOf2023
          .addYears(1)
          .should
          .be(Week(startOfWeek: Date(year: 2024, month: 1, day: 1)));
      isoFirstWeekOf2023
          .subYears(1)
          .should
          .be(Week(startOfWeek: Date(year: 2022, month: 1, day: 3)));

      // non iso
      firstWeekOf2023
          .addYears(1)
          .should
          .be(Week(startOfWeek: Date(year: 2023, month: 12, day: 31)));
      firstWeekOf2023
          .subYears(1)
          .should
          .be(Week(startOfWeek: Date(year: 2022, month: 1, day: 2)));
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
        final week = Week.parse(dateStr);
        week.should.be(Week(startOfWeek: Date(year: 2012, month: 2, day: 27)));
      }
    });

    test('parse with formatter', () {
      const format = "MMMM dd, yyyy 'at' hh:mm:ss a Z";
      final week =
          Week.parse('August 6, 2020 at 5:44:45 PM UTC+7', format: format);
      week.should.be(Week(startOfWeek: Date(year: 2020, month: 8, day: 3)));
    });

    test('try parse invalid date w/o formatter', () {
      final week = Week.tryParse('12/31/2021');
      week.should.beNull();
    });

    test('try parse with format', () {
      final week = Week.tryParse('12/31/2021', format: 'MM/dd/yyyy');
      week.should.be(Week(startOfWeek: Date(year: 2021, month: 12, day: 27)));
    });

    test('toString', () {
      isoFirstWeekOf2023.toString().should.be('2023-01-02');
      isoLastWeekOf2023.toString().should.be('2023-12-25');
      Week.firstISOWeekOfEpoch.toString().should.be('1969-12-29');
      Week.firstISOWeekOfTime.toString().should.be('0001-01-01');
    });

    test('toKey', () {
      isoFirstWeekOf2023.toKey().should.be('2023-01-02');
      isoLastWeekOf2023.toKey().should.be('2023-12-25');
      Week.firstISOWeekOfEpoch.toKey().should.be('1969-12-29');
      Week.firstISOWeekOfTime.toKey().should.be('0001-01-01');
    });

    test('fromKey', () {
      Week.fromKey('2023-01-02').should.be(isoFirstWeekOf2023);
      Week.fromKey('2023-12-25').should.be(isoLastWeekOf2023);
      Week.fromKey('1969-12-29').should.be(Week.firstISOWeekOfEpoch);
      Week.fromKey('0001-01-01').should.be(Week.firstISOWeekOfTime);
    });
  });

  group('Test DAY enum', () {
    test('test fromNumber()', () {
      DAY.fromNumber(1).should.be(DAY.monday);
      DAY.fromNumber(2).should.be(DAY.tuesday);
      DAY.fromNumber(3).should.be(DAY.wednesday);
      DAY.fromNumber(4).should.be(DAY.thursday);
      DAY.fromNumber(5).should.be(DAY.friday);
      DAY.fromNumber(6).should.be(DAY.saturday);
      DAY.fromNumber(7).should.be(DAY.sunday);
    });

    test('test day number', () {
      (monday.weekday == DAY.monday.number).should.beTrue();
      (tuesday.weekday == DAY.tuesday.number).should.beTrue();
      (wednesday.weekday == DAY.wednesday.number).should.beTrue();
      (thursday.weekday == DAY.thursday.number).should.beTrue();
      (friday.weekday == DAY.friday.number).should.beTrue();
      (saturday.weekday == DAY.saturday.number).should.beTrue();
      (sunday2.weekday == DAY.sunday.number).should.beTrue();
    });

    test('test enum value', () {
      (monday.getDAY == DAY.monday).should.beTrue();
      (tuesday.getDAY == DAY.tuesday).should.beTrue();
      (wednesday.getDAY == DAY.wednesday).should.beTrue();
      (thursday.getDAY == DAY.thursday).should.beTrue();
      (friday.getDAY == DAY.friday).should.beTrue();
      (saturday.getDAY == DAY.saturday).should.beTrue();
      (sunday2.getDAY == DAY.sunday).should.beTrue();
    });

    test('test enum titles in en_US', () {
      DAY.monday.title('en_US').should.be('Monday');
      DAY.tuesday.title('en_US').should.be('Tuesday');
      DAY.wednesday.title('en_US').should.be('Wednesday');
      DAY.thursday.title('en_US').should.be('Thursday');
      DAY.friday.title('en_US').should.be('Friday');
      DAY.saturday.title('en_US').should.be('Saturday');
      DAY.sunday.title('en_US').should.be('Sunday');
    });

    test('test enum short titles in en_US', () {
      DAY.monday.shortTitle('en_US').should.be('Mon');
      DAY.tuesday.shortTitle('en_US').should.be('Tue');
      DAY.wednesday.shortTitle('en_US').should.be('Wed');
      DAY.thursday.shortTitle('en_US').should.be('Thu');
      DAY.friday.shortTitle('en_US').should.be('Fri');
      DAY.saturday.shortTitle('en_US').should.be('Sat');
      DAY.sunday.shortTitle('en_US').should.be('Sun');
    });

    test('test enum acronym in en_US', () {
      DAY.monday.acronym('en_US').should.be('M');
      DAY.tuesday.acronym('en_US').should.be('T');
      DAY.wednesday.acronym('en_US').should.be('W');
      DAY.thursday.acronym('en_US').should.be('T');
      DAY.friday.acronym('en_US').should.be('F');
      DAY.saturday.acronym('en_US').should.be('S');
      DAY.sunday.acronym('en_US').should.be('S');
    });

    test('test enum titles in fr', () {
      DAY.monday.title('fr').should.be('lundi');
      DAY.tuesday.title('fr').should.be('mardi');
      DAY.wednesday.title('fr').should.be('mercredi');
      DAY.thursday.title('fr').should.be('jeudi');
      DAY.friday.title('fr').should.be('vendredi');
      DAY.saturday.title('fr').should.be('samedi');
      DAY.sunday.title('fr').should.be('dimanche');
    });
  });

  group('Test dates', () {
    test('test non iso dates', () {
      firstWeekOf2023[DAY.sunday].should.be(sunday1);
      firstWeekOf2023[DAY.monday].should.be(monday);
      firstWeekOf2023[DAY.tuesday].should.be(tuesday);
      firstWeekOf2023[DAY.wednesday].should.be(wednesday);
      firstWeekOf2023[DAY.thursday].should.be(thursday);
      firstWeekOf2023[DAY.friday].should.be(friday);
      firstWeekOf2023[DAY.saturday].should.be(saturday);

      firstWeekOf2023.sunday.should.be(sunday1);
      firstWeekOf2023.monday.should.be(monday);
      firstWeekOf2023.tuesday.should.be(tuesday);
      firstWeekOf2023.wednesday.should.be(wednesday);
      firstWeekOf2023.thursday.should.be(thursday);
      firstWeekOf2023.friday.should.be(friday);
      firstWeekOf2023.saturday.should.be(saturday);
    });

    test('test iso dates', () {
      isoFirstWeekOf2023[DAY.monday].should.be(monday);
      isoFirstWeekOf2023[DAY.tuesday].should.be(tuesday);
      isoFirstWeekOf2023[DAY.wednesday].should.be(wednesday);
      isoFirstWeekOf2023[DAY.thursday].should.be(thursday);
      isoFirstWeekOf2023[DAY.friday].should.be(friday);
      isoFirstWeekOf2023[DAY.saturday].should.be(saturday);
      isoFirstWeekOf2023[DAY.sunday].should.be(sunday2);

      isoFirstWeekOf2023.monday.should.be(monday);
      isoFirstWeekOf2023.tuesday.should.be(tuesday);
      isoFirstWeekOf2023.wednesday.should.be(wednesday);
      isoFirstWeekOf2023.thursday.should.be(thursday);
      isoFirstWeekOf2023.friday.should.be(friday);
      isoFirstWeekOf2023.saturday.should.be(saturday);
      isoFirstWeekOf2023.sunday.should.be(sunday2);
    });
  });

  group('test copyWith', () {
    final week = Week(startOfWeek: Date(year: 2022, month: 1, day: 1));

    test('startOfWeek', () {
      week
          .copyWith(startOfWeek: Date(year: 2022, month: 1, day: 1))
          .should
          .be(Week(startOfWeek: Date(year: 2022, month: 1, day: 1)));
    });
  });

  group('next / previous', () {
    final week = Week(startOfWeek: Date(year: 2022, month: 1, day: 1));
    test('test next', () {
      week.next.should
          .be(Week(startOfWeek: Date(year: 2022, month: 1, day: 8)));
    });

    test('test previous', () {
      Week(startOfWeek: Date(year: 2022, month: 1, day: 8))
          .previous
          .should
          .be(week);
    });
  });

  group('convenient methods', () {
    final week = Week.startDateTime(DateTime(2023, 1, 2));
    test('test isISOWeek', () {
      week.isISOWeek.should.be(true);
    });

    test('test startDay', () {
      week.startDay.should.be(DAY.monday);
    });

    test('test endDay', () {
      week.endDay.should.be(DAY.sunday);
    });
  });
}
