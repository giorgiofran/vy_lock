/// Copyright © 2017 Vidya Sas. All rights reserved.
/// Created by Giorgio on 14/10/2016.

import 'dart:async';

typedef recallFunction = Future<T> Function<T>(Map values); //Function(Map);

@Deprecated('Mutex class is simpler to use')
class Lock {
  Future<Null> _isWorking;
  Completer<Null> _completer;
  bool get locked => _isWorking != null;

  lock() {
    _completer = Completer();
    _isWorking = _completer.future;
  }

  unlock() {
    _completer.complete();
    _isWorking = null;
  }

  // Todo force all callers to pass the function
  Future<T> waitLock<T>(recallFunction functionToBeCalled, Map values) async {
    await _isWorking;
    return functionToBeCalled<T>(values);
  }
}
