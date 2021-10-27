import 'package:date_time/date_time.dart';
import 'package:shouldly/shouldly.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('compare time', () {
    const time = Time(21, mins: 01);
    const time2 = Time(21, mins: 01);

    time.should.be(time2);
  });

  test('compare time', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    time2.isAfter(time).should.beTrue();
  });

  test('compare time (2)', () {
    final time = Time(21, mins: 01);
    final time2 = Time(22, mins: 01);

    final res = time2 >= time;
    res.should.beTrue();
  });
}
