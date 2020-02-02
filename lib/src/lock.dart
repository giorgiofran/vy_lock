/// Copyright © 2017 Vidya Sas. All rights reserved.
/// Created by Giorgio on 14/10/2016.

import 'dart:async';

typedef recallFunction = Future<T> Function<T>(Map values); //Function(Map);

@Deprecated('Mutex class is simpler to use')
class Lock {
  Future<Null> _isWorking;
  Completer<Null> _completer;
  recallFunction _function;
  bool get locked => _isWorking != null;

  lock() {
    _completer = Completer();
    _isWorking = _completer.future;
  }

  unlock() {
    _completer.complete();
    _isWorking = null;
  }

  Future<T> waitLock<T>(Map values) async {
    await _isWorking;
    return _function<T>(values);
  }

  setFunction(recallFunction fun) {
    if (_function == null) _function = fun;
  }
}
