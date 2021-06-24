import 'iterable_utils.dart';

class ListUtils {
  /// Convert a List of [object] to a List of another type
  static List<O>? toListFromObject<I, O>(
      Iterable<I>? object, ListItemBuilder<I, O> f,
      {ListError<O>? onError,
      bool returnNonNullList = false,
      bool acceptNullItems = false}) {
    try {
      if (object != null) {
        List<O> list = <O>[];

        for (I item in object) {
          if (acceptNullItems == true || item != null) {
            addNonNull(list, f(item));
          }
        }

        return list;
      }

      if (returnNonNullList == true) {
        return List<O>.empty();
      } else {
        return null;
      }
    } catch (e, trace) {
      if (onError != null) {
        return onError(e, trace);
      } else {
        return null;
      }
    }
  }

  static void addNonNull<T>(List<T> list, T value) {
    if (value != null) {
      list.add(value);
    }
  }

  static void addAllNonNull<T>(List<T> list, Iterable<T> values) {
    if (IterableUtils.isNotEmpty(values)) {
      list.addAll(values);
    }
  }

  static int removeWithOccurrences<T>(List<T> it, T value) {
    int count = 0;

    it.removeWhere((T element) {
      if (element == value) {
        count++;
        return true;
      } else {
        return false;
      }
    });

    return count;
  }

  static bool replace<T>(List<T> list, T oldItem, T newItem) {
    int position = list.indexOf(oldItem);

    if (position == -1) {
      return false;
    }

    list.removeAt(position);
    list.insert(position, newItem);
    return true;
  }
}

typedef ListMapItemBuilder<T> = T Function(Map<String, Object> object);
typedef ListItemBuilder<I, O> = O Function(I object);
typedef ListError<O> = List<O> Function(Object e, StackTrace trace);

extension ListUtilsExtension<T> on List<T> {
  void addNonNull<T>(T value) {
    ListUtils.addNonNull(this, value);
  }

  void addAllNonNull<T>(Iterable<T> values) {
    ListUtils.addAllNonNull(this, values);
  }

  int removeWithOccurrences(T value) {
    return ListUtils.removeWithOccurrences(this, value);
  }

  bool replace(T oldItem, T newItem) {
    return ListUtils.replace(this, oldItem, newItem);
  }
}

extension ListListUtilsExtension on List<List<String>> {
  String flat() {
    StringBuffer buffer = StringBuffer();

    for (List<String> row in this) {
      for (String item in row) {
        buffer.write(item);
      }
    }

    return buffer.toString();
  }
}
