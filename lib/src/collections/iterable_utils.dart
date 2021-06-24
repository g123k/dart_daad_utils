class IterableUtils {
  const IterableUtils._();

  static bool isListOfStrings<T>(List<T>? list, [bool acceptNull = false]) {
    if (list == null) {
      return false;
    } else if (list.length == 0) {
      return true;
    } else {
      for (T item in list) {
        if (item == null) {
          if (!acceptNull) {
            return false;
          } else {
            continue;
          }
        } else if (item is! String) {
          return false;
        }
      }

      return true;
    }
  }

  static int length<T>(Iterable<T> it) {
    if (isEmpty(it)) {
      return 0;
    } else {
      return it.length;
    }
  }

  static bool isListOfMaps(Object? obj) {
    if (obj == null) {
      return false;
    } else if (obj is List) {
      return obj.where((dynamic item) => item is! Map).length == 0;
    }
    return false;
  }

  static bool startsWith(List<String> list, String value) {
    for (String item in list) {
      if (item.startsWith(value)) {
        return true;
      }
    }
    return false;
  }

  static bool isEmpty<T>(Iterable<T>? list) {
    return list == null || list.isEmpty;
  }

  static bool isNotEmpty<T>(Iterable<T>? list) {
    return list != null && list.isNotEmpty;
  }

  static bool containsAtLeastOneElement<T>(Iterable<T>? it1, Iterable<T>? it2) {
    if (it1 == null || it2 == null) {
      return false;
    }

    try {
      return it1.firstWhere((T element) => it2.contains(element)) != null;
    } on StateError {
      return false;
    }
  }

  static bool equals<E1, E2>(Iterable<E1> it1, Iterable<E2> it2) {
    if (it1.runtimeType != it2.runtimeType || it1.length != it2.length) {
      return false;
    }

    for (int i = 0; i != it1.length; i++) {
      if (it1.elementAt(i) != it2.elementAt(i)) {
        return false;
      }
    }

    return true;
  }

  static Iterable<T> mapIndexed<E, T>(
      Iterable<E> it, T function(E value, int position)) {
    int pos = 0;
    return it.map((E e) => function(e, pos++));
  }
}

extension IterableExtensions<E> on Iterable<E> {
  int position(E element) {
    int position = 0;

    for (E item in this) {
      if (item == element) {
        return position;
      }

      position++;
    }

    return -1;
  }

  int firstPositionOf(bool test(E element)) {
    int position = 0;

    for (E item in this) {
      if (test(item) == true) {
        return position;
      }

      position++;
    }

    return -1;
  }

  E? get firstOrNull => isNotEmpty ? first : null;

  E? firstWhereOrNull(bool test(E element)) {
    try {
      return firstWhere(test);
    } on StateError {
      return null;
    }
  }

  bool containsWhere(bool test(E element)) {
    try {
      return firstWhere(test) != null;
    } on StateError {
      return false;
    }
  }

  Iterable<E?> whereNonNull() {
    return where((E? element) => element != null);
  }

  bool equals<E1>(Iterable<E1> it) {
    return IterableUtils.equals(this, it);
  }

  Iterable<T> mapIndexed<T>(T function(E value, int position)) {
    return IterableUtils.mapIndexed(this, function);
  }

  E? get safeLast {
    if (length == 0) {
      return null;
    } else {
      return last;
    }
  }
}

extension IterableIterableExtensions<E> on Iterable<Iterable<E>> {
  bool containsElement(E element) {
    for (Iterable<E> iterable in this) {
      if (iterable.contains(element)) {
        return true;
      }
    }
    return false;
  }

  bool containsWhere(bool test(E element)) {
    for (Iterable<E> iterable in this) {
      if (iterable.containsWhere(test)) {
        return true;
      }
    }
    return false;
  }
}
