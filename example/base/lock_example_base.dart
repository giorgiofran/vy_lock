// Copyright (c) 2017, Vidya Sas. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:synchronized/synchronized.dart' as prefix0;
import 'package:vy_lock/src/mutex.dart';
import 'package:vy_lock/vy_lock.dart' show Lock;

/// Example class on how to use LockManager
class LockExample {
  /// You can use it easily in more than one method inside your classes.
  /// In this case you need a Locker instance per method.
  Lock fooLock = Lock();

  /// convenient way of defining a parameter name
  static const String constValue = 'value';

  /// This is the method that we want to be executed one at a time.
  Future<T> foo<T>(int value) async {
    // ********** Start lock definition area *****************
    /// this is the function used to execute again the locked calls.
    /// The name of the function can be anything, it must be declared
    /// as below (fooLock.setFunction(_recall))
    /// Here we call our function with the parameter received in the
    /// values Map. The values are set in the waitLock call
    /// Ex. fooLock.waitLock({constValue: value})
    Future<V> _recall<V>(Map values) => foo<V>(values[constValue]);

    /// check if the method is already locked, if yes, the waitLock
    /// method is called.
    /// We have to pass the received (foo) parameter into a Map
    /// that will be used by the _recall function
    if (fooLock.locked) {
      return await fooLock.waitLock<T>(_recall, {constValue: value});
    }
    // ********** End lock definition area *****************

    /// locks the method, everything executed between
    /// Lock and unlock is guaranteed to be
    /// called one at a time.
    fooLock.lock();

    await foo2(value);
    await foo3(value);
    T ret = foo5(value);

    /// unlocks the method, new calls to this method can be executed
    fooLock.unlock();

    return ret;
  }
}

class WithoutLockExample {
  Future<int> foo(int value) async {
    await foo2(value);
    await foo3(value);
    int ret = foo5(value);

    return ret;
  }
}

class SynchronizedExample {
  final lock = prefix0.Lock();
  Future<int> foo(int value) async {
    int ret = 0;
    await lock.synchronized(() async {
      await foo2(value);
      await foo3(value);
      ret = foo5(value);
    });
    return ret;
  }
}

class MutexExample {
  final lock = Mutex();
  Future<int> foo(int value) async {
    int ret = 0;
    await lock.mutex(() async {
      await foo2(value);
      await foo3(value);
      ret = foo5(value);
    });
    return ret;
  }
}

foo2(int value) async => print('foo2 of $value');
foo3(int value) async {
  print('foo3 of $value before');
  await foo4(value);
  print('foo3 of $value after');
}

foo4(int value) async => print('foo4 of $value');
foo5(int value) {
  print('foo5 of $value');
  return value;
}
