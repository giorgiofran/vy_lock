import 'dart:async';

class Mutex {
  Completer? last;

  mutex(Function fun) async {
    Completer actual = Completer();

    Completer? previous = last;
    last = actual;
    try {
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
