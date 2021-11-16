import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  given('DateRange', () {
    const range = DateRange(
      Date(2021, 1, 1),
      Date(2021, 12, 31),
    );

    then('should be valid', () {
      range.isValid.should.beTrue();
    });

    then('toString() should be with -', () {
      range.toString().should.be('2021-01-01-2021-12-31');
    });
  });

  test('Two date ranges should be equal', () {
    const dateRange1 = DateRange(Date(2021, 3, 3), Date(2021, 5, 7));
    const dateRange2 = DateRange(Date(2021, 3, 3), Date(2021, 5, 7));

    dateRange2.should.be(dateRange1);
  });
}
