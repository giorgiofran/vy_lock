// Copyright (c) 2017, Vidya Sas. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'base/lock_example_base.dart';

/// I you use the await pattern extensively you could have no needs of the
/// lockManager.
/// The following is the case in which you mix await and callbacks, either
/// intentionally or by error.
/// If you see the output, the calls with the values of 7, and 1 are
/// mixed up.
main() async {
  WithoutLockExample withoutLockExample = new WithoutLockExample();
  int val = await withoutLockExample.foo(5);
  print(val);
  withoutLockExample.foo(7).then((int value) => print(value));
  val = await withoutLockExample.foo(1);
  print(val);
  val = await withoutLockExample.foo(3);
  print(val);
}

/// expected Output:
/// foo2 of 5
/// foo3 of 5 before
/// foo4 of 5
/// foo3 of 5 after
/// 5
/// foo2 of 7
/// foo2 of 1
/// foo3 of 7 before
/// foo3 of 1 before
/// foo4 of 7
/// foo3 of 7 after
/// 7
/// foo4 of 1
/// foo3 of 1 after
/// 1
/// foo2 of 3
/// foo3 of 3 before
/// foo4 of 3
/// foo3 of 3 after
/// 3