class BoolUtils {
  const BoolUtils._();

  static bool? parseBool(dynamic value, [bool? defaultValue]) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      return value == '1' || value == 'true';
    } else if (defaultValue != null) {
      return defaultValue;
    } else {
      throw Exception('Not a boolean !');
    }
  }
}

extension BoolUtilsExtensions on bool {
  int toInt() {
    return this ? 1 : 0;
  }
}
