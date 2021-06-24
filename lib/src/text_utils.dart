import 'dart:math' as math;

import 'num_utils.dart';

class TextUtils {
  const TextUtils._();

  static String? parseString(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is String) {
      return value;
    } else {
      return value.toString();
    }
  }

  static bool isEmpty(String? text) {
    if (text == null) {
      return true;
    } else {
      return text.isEmpty;
    }
  }

  static bool minLength(String? text, int length) {
    if (text == null) {
      return true;
    } else {
      return text.length >= length;
    }
  }

  static bool isNotEmpty(String? text) {
    if (text == null) {
      return false;
    } else {
      return text.isNotEmpty;
    }
  }

  static String joinPath(String path1, String path2) {
    if (path1.endsWith('/')) {
      return '$path1$path2';
    } else {
      return '$path1/$path2';
    }
  }

  static bool isURL(String url) {
    return RegExp(
                r'(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?',
                caseSensitive: false)
            .firstMatch('https://www.google.com') !=
        null;
  }

  static List<String> toListOfCharacters(String str) {
    List<String> characters = <String>[];

    for (int i = 0; i != str.length; i++) {
      characters.add(str[i]);
    }

    return characters;
  }
}

extension TextExtensions on String {
  double? toDouble() => NumUtils.parseDouble(this);

  int asInt() => NumUtils.parseInt(this)!;

  int? toInt() => NumUtils.parseInt(this);

  num? asNum() => NumUtils.parseNum(this)!;

  num? toNum() => NumUtils.parseNum(this);

  bool get isUrl => TextUtils.isURL(this);

  String safeSubstring(int start, int end) =>
      substring(start, math.min(length, end));

  String joinPath(String part) => TextUtils.joinPath(this, part);

  List<String> toListOfCharacters() => TextUtils.toListOfCharacters(this);
}
