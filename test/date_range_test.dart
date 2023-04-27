import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  given('DateRange', () {
    const range = DateRange(
      Date(year: 2021),
      Date(year: 2021, month: 12, day: 31),
    );

    then('should be valid', () {
      range.isValid.should.beTrue();
    });

    then('toString() should return format "d/M/YYYY - d/M/YYYY"', () {
      range.toString().should.be('1/1/2021 - 12/31/2021');
    });
  });

  test('Two date ranges should be equal', () {
    const dateRange1 = DateRange(
      Date(
        year: 2021,
        month: 3,
        day: 3,
      ),
      Date(
        year: 2021,
        month: 5,
        day: 7,
      ),
    );
    const dateRange2 = DateRange(
      Date(year: 2021, month: 3, day: 3),
      Date(year: 2021, month: 5, day: 7),
    );

    dateRange2.should.be(dateRange1);
    dateRange2.hashCode.should.be(dateRange1.hashCode);
  });
}
