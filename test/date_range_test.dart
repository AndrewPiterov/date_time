import 'package:date_time/date_time.dart';
import 'package:given_when_then_unit_test/given_when_then_unit_test.dart';
import 'package:shouldly/shouldly.dart';

void main() {
  given('DateRange', () {
    final range = DateRange(
      const Date(2021, 1, 1),
      const Date(2021, 12, 31),
    );

    then('should be valid', () {
      range.isValid.should.beTrue();
    });

    then('toString() should be with -', () {
      range.toString().should.be('2021-01-01-2021-12-31');
    });
  });
}
