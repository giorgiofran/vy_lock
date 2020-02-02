# vy_lock

Allows a method to be executed one at a time (mutex).


## Usage

A simple usage example:

    class LockExample {
      /// You can use it easily in more than one method inside your classes.
      /// In this case you need a Locker instance per method.
      Lock fooLock = new Lock();
      /// convenient way of defining a parameter name
      static const String constValue = 'value';
    
      /// This is the method that we want to be executed one at a time.
      Future<int> foo(int value) async {
        // ********** Start lock definition area *****************
        /// this is the function used to execute again the locked calls.
        /// The name of the function can be anything, it must be declared
        /// as below (fooLock.setFunction(_recall))
        /// Here we call our function with the parameter received in the
        /// values Map. The values are set in the waitLock call
        /// Ex. fooLock.waitLock({constValue: value})
        _recall(Map values) => foo(values[constValue]);
    
        /// check if the method is already locked, if yes, the waitLock
        /// method is called.
        /// We have to pass the received (foo) parameter into a Map
        /// that will be used by the _recall function
        if (fooLock.locked) {
          return await fooLock.waitLock({constValue: value});
        }
        /// Sets the recall function
        fooLock.setFunction(_recall);
        // ********** End lock definition area *****************
    
        /// locks the method, everything executed between
        /// Lock and unlock is guaranteed to be
        /// called one at a time.
        fooLock.lock();
    
        await foo2(value);
        await foo3(value);
        int ret = foo5(value);
    
        /// unlocks the method, new calls to this method can be executed
        fooLock.unlock();
    
        return ret;
      }
    }


see example folder for further examples.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/giorgiofran/vy_lock/issues
