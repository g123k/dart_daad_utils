class MapUtils {
  const MapUtils._();

  static Map<K, V> add<K, V>(Map<K, V> map, K key, V value) {
    map[key] = value;
    return map;
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

extension MapUtilsExtensions<K, V> on Map<K, V> {
  Map<K, V> add(K key, V value) => MapUtils.add(this, key, value);
  bool containsKeys(Iterable<K> keys) => MapUtils.containsKeys(this, keys);
}
