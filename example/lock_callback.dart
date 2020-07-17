// Copyright (c) 2017, Vidya Sas. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'base/lock_example_base.dart';

main() {
  LockExample lockExample = LockExample();
  lockExample.foo<int>(5).then((int value) => print(value));
  lockExample.foo<int>(7).then((int value) => print(value));
  lockExample.foo<int>(1).then((int value) => print(value));
  lockExample.foo<int>(3).then((int value) => print(value));
}

/// expected Output:
/// foo2 of 5
/// foo3 of 5 before
/// foo4 of 5
/// foo3 of 5 after
/// 5
/// foo2 of 7
/// foo3 of 7 before
/// foo4 of 7
/// foo3 of 7 after
/// 7
/// foo2 of 1
/// foo3 of 1 before
/// foo4 of 1
/// foo3 of 1 after
/// 1
/// foo2 of 3
/// foo3 of 3 before
/// foo4 of 3
/// foo3 of 3 after
/// 3
