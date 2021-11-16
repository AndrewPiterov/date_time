import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Message', () {
    final error = DateTimeError('some error');
    error.message.should.be('some error');
  });
}
