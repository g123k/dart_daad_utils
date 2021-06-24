import 'package:intl/intl.dart';

class NumUtils {
  const NumUtils._();

  static double? parseDouble(dynamic value,
      [double? defaultValue, bool acceptNullValueDefaultValue = false]) {
    if (value is double) {
      return value;
    } else if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    } else if (defaultValue != null || acceptNullValueDefaultValue == true) {
      return defaultValue;
    } else {
      throw Exception('Not a double !');
    }
  }

  static int? parseInt(dynamic value,
      [int? defaultValue, bool acceptNullValueDefaultValue = false]) {
    if (value is int) {
      return value;
    } else if (value is num) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? defaultValue;
    } else if (defaultValue != null || acceptNullValueDefaultValue == true) {
      return defaultValue;
    } else {
      throw Exception('Not an int !');
    }
  }

  static num? parseNum(dynamic value,
      [num? defaultValue, bool acceptNullValueDefaultValue = false]) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value) ?? defaultValue;
    } else if (defaultValue != null || acceptNullValueDefaultValue == true) {
      return defaultValue;
    } else {
      throw Exception('Not a num !');
    }
  }

  static String toFormattedString(num? num, [int digits = 3]) {
    if (num == null) {
      return '';
    }

    if (num is double && digits == 0) {
      return NumberFormat.decimalPattern('fr').format(num);
    } else {
      if (digits == 0) {
        return num.toString();
      } else {
        return NumberFormat(
                '####.${List<String>.filled(digits, '0').join()}', 'fr')
            .format(num);
      }
    }
  }

  static int numberOfDigits(num value) {
    String numValue = value.toString();

    if (!numValue.contains('.')) {
      return 0;
    } else {
      String replacedValue = numValue.replaceFirst(RegExp(r'[0-9]*\.'), '');

      if (replacedValue == '0') {
        return 0;
      }

      return replacedValue.length;
    }
  }

  static String asString(int number, int elements) {
    return NumberFormat(List<String>.generate(elements, (_) => '0').join())
        .format(number);
  }
}

extension IntExtensions on int {
  String asString(int elements) => NumUtils.asString(this, elements);
}
