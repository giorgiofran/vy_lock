import 'dart:async';

class Mutex {
  Completer last;

  mutex(Function fun) async {
    Completer actual;
    try {
      Completer previous = last;
      actual = Completer();
      last = actual;

      if (previous != null) {
        await previous.future;
      }
      await fun();
    } finally {
      if (identical(actual, last)) {
        last = null;
      }
      actual.complete();
    }
  }
}
