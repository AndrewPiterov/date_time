import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/test.dart';

void main() {
  test('empty', () {
    const time = Time(hour: 0);
    time.title.should.be('00:00:00:000');
  });

  test('h', () {
    const Time(hour: 4, second: 1, millisecond: 234)
        .title
        .should
        .be('04:00:01:234');
  });

  test('h 2', () {
    final r = Time.fromDuration(const Duration(minutes: 1, seconds: 8));
    r.title.should.be('00:01:08:000');
  });

  test('ms', () {
    Time.fromMilliseconds(1).title.should.be('00:00:00:001');
  });

  test('s', () {
    Time.fromMilliseconds(1001).title.should.be('00:00:01:001');
  });
}
