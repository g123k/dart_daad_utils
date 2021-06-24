class SetUtils {
  const SetUtils._();

  static Set<T> removeLast<T>(Set<T> set) {
    if (set.length > 0) {
      set.remove(set.last);
    }

    return set;
  }

  static bool containsKeys<K, V>(Map<K, V> map, Iterable<K> keys) {
    for (K key in keys) {
      if (!map.containsKey(key)) {
        return false;
      }
    }
    return true;
  }
}

extension SetUtilsUtilsExtensions<T> on Set<T> {
  Set<T> removeLast() => SetUtils.removeLast(this);
}
