import 'package:date_time/date_time.dart';
import 'package:intl/intl.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('format date', () {
    const date = Date(year: 2022);
    DateFormat('yyyy-MM-dd').formatDate(date).should.be('2022-01-01');
  });
}
