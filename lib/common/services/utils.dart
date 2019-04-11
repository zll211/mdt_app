import 'package:intl/intl.dart';

/// 是否是今天
bool isToday(DateTime date) {
  final _today = DateTime.now();
  return date != null && _today.year == date.year && _today.month == date.month && _today.day == date.day;
}

/// 是否是昨天
bool isYesterday(DateTime date) {
  final _today = DateTime.now();
  return date != null &&
      DateTime(_today.year, _today.month, _today.day).add(Duration(days: -1)) ==
          DateTime(date.year, date.month, date.day);
}

/// 是否是今年
bool isCurrentYear(DateTime date) {
  final _today = DateTime.now();
  return date != null && _today.year == date.year;
}

/// 截取时间
String getLocaleTime(DateTime date) {
  if (isToday(date)) {
    return DateFormat.jm().format(date);
  } else if (isYesterday(date)) {
    return "昨天";
  } else if (isCurrentYear(date)) {
    return DateFormat.MMMd().format(date);
  } else {
    return DateFormat.yMMMMd().format(date);
  }
}
