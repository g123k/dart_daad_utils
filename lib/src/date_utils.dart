import 'package:intl/intl.dart';

class DateUtils {
  const DateUtils._();

  static DateTime merge(DateTime date, DateTime? time) {
    return DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? date.hour,
        time?.minute ?? date.minute,
        time?.second ?? date.second,
        time?.millisecond ?? date.millisecond,
        time?.microsecond ?? date.microsecond);
  }

  static DateTime mergeFromText(String date, String time) {
    // 2012-02-27 13:27:00
    return DateTime.parse('$date $time');
  }

  static int diffInDays(DateTime d1, DateTime d2) {
    return d1.minTime().difference(d2.minTime()).inDays;
  }

  static Duration diff(DateTime date) {
    return DateTime.now().difference(date);
  }

  static DateTimeDifference difference(DateTime d1, DateTime d2) {
    return differenceFromDuration(d1.difference(d2).inMinutes);
  }

  static DateTimeDifference differenceFromDuration(int diff) {
    int days = (diff / (24 * 60)).floor();
    if (days > 0) {
      diff -= days * 24 * 60;
    }

    int hours = (diff / 60).floor();
    if (hours > 0) {
      diff -= hours * 60;
    }

    return DateTimeDifference(days, hours, diff);
  }

  static DateTime year() {
    DateTime now = DateTime.now();
    return now.copyWith(day: 364);
  }

  static List<int> daysPerMonth(int year) => <int>[
        31,
        isLeapYear(year) ? 29 : 28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31,
      ];

  static bool isLeapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    }

    return leapYear;
  }
}

class DateTimeDifference {
  final int days;
  final int hours;
  final int minutes;

  DateTimeDifference(this.days, this.hours, this.minutes);

  @override
  String toString() {
    return 'DateTimeDifference{days: $days, hours: $hours, minutes: $minutes}';
  }
}

extension DateTimeExtensions on DateTime {
  bool get isFirstDayOfMonth => 1 == day;

  bool get isLastDayOfMonth => DateUtils.daysPerMonth(year)[month - 1] == day;

  DateTime mergeWithTime(DateTime time) => DateUtils.merge(this, time);

  DateTime mergeWithDate(DateTime date) => DateUtils.merge(date, this);

  int diffInDays(DateTime date) => DateUtils.diffInDays(this, date);

  Duration diff() => DateUtils.diff(this);

  DateTimeDifference dateTimeDifference(DateTime date) =>
      DateUtils.difference(this, date);

  String formatDate({String format = 'd MMMM'}) =>
      DateFormat(format).format(this);

  String formatTime({String format = 'HH:mm'}) =>
      DateFormat(format).format(this);

  DateTime addYear() => copyWith(year: year + 1);

  DateTime minTime() =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);

  DateTime maxTime() => copyWith(
      hour: 23, minute: 59, second: 59, millisecond: 59, microsecond: 59);

  bool isSameDayOrAfter(DateTime other) => isAfter(other) || isSameDay(other);

  bool isSameDayOrBefore(DateTime other) => isBefore(other) || isSameDay(other);

  bool isSameDay(DateTime? other) =>
      other != null &&
      year == other.year &&
      month == other.month &&
      day == other.day;

  bool isBetween(DateTime minDate, DateTime maxDate) =>
      this.isSameDayOrAfter(minDate) && this.isSameDayOrBefore(maxDate);

  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
