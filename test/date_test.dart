import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  given('Date', () {
    final today = Date.today;
    final tomorrow = Date.tomorrow;

    then('Today is before tomorrow', () {
      (today < tomorrow).should.beTrue();
      (today <= tomorrow).should.beTrue();
    });

    then('Tomorrow is after tomorrow', () {
      (tomorrow > today).should.beTrue();
      (tomorrow >= today).should.beTrue();
    });

    then('Today is today', () {
      (today >= Date.today).should.beTrue();
    });
  });

  given('DateTime', () {
    final dateTime = DateTime(2020, 11, 30, 14, 33, 17);

    then('date should be equal to', () {
      dateTime.date.should.be(const Date(2020, 11, 30));
    });

    then('time should be equal to', () {
      dateTime.time.should.be(const Time(14, mins: 33, secs: 17));
    });

    when('Compare with time greate', () {
      final dateTimeAfter = dateTime.add(const Duration(hours: 24));

      then('second time should be after', () {
        dateTimeAfter.date.isAfter(dateTime.date).should.beTrue();
      });
    });

    when('Compare with the same', () {
      final dateTimeAfter = Date(dateTime.year, dateTime.month, dateTime.day);

      then('second time should be the same', () {
        dateTime.date.isAfter(dateTimeAfter).should.not.beTrue();
        dateTimeAfter.isAfter(dateTime.date).should.not.beTrue();
        dateTimeAfter.isSame(dateTime.date).should.beTrue();
      });
    });
  });

  given('Today dateTime', () {
    final today = DateTime.now();

    then('Date should be today', () {
      today.date.isToday.should.beTrue();
    });

    when('add 24 hours', () {
      final nextDay = Date(2021, 1, 1).add(Duration(hours: 24));
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
}
