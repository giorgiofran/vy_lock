import "dart:async";

import "package:test/test.dart";
import '../example/base/lock_example_base.dart';

void main() {
  test("new Future.value() returns the value", () async {
    LockExample lockExample = new LockExample();

    lockExample.foo<int>(5).then((int value) => print(value));
    lockExample.foo<int>(7).then((int value) => print(value));
    lockExample.foo<int>(1).then((int value) => print(value));
    lockExample.foo<int>(3).then((int value) => print(value));

    var value = await new Future.value(10);
    expect(value, equals(10));
  });
}
