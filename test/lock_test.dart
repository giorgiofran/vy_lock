import "dart:async";

import "package:test/test.dart";
import '../example/base/lock_example_base.dart';

void main() {
  test("new Future.value() returns the value", () async {
    LockExample lockExample = LockExample();

    // ignore: unawaited_futures
    lockExample.foo<int>(5).then((int value) => print(value));
    // ignore: unawaited_futures
    lockExample.foo<int>(7).then((int value) => print(value));
    // ignore: unawaited_futures
    lockExample.foo<int>(1).then((int value) => print(value));
    // ignore: unawaited_futures
    lockExample.foo<int>(3).then((int value) => print(value));

    var value = await Future.value(10);
    expect(value, equals(10));
  });
}
