import 'package:intl/intl.dart';

String formatDow(DateTime dateTime) => '일월화수목금토'[dateTime.weekday % 7];
String formatDateTime(DateTime dateTime) => DateFormat('y-M-d').format(dateTime);
String formatDateTimeDow(DateTime dateTime) => '${formatDateTime(dateTime)} ${formatDow(dateTime)}';

String dateTimeAgo(DateTime src, DateTime dst) {
  final diff = dst.difference(src);
  if (diff.inDays > 365) {
    return '${diff.inDays ~/ 365}년 전';
  } else if (diff.inDays > 30) {
    return '${diff.inDays ~/ 30}달 전';
  } else if (diff.inDays > 0) {
    return '${diff.inDays}일 전';
  } else if (diff.inHours > 0) {
    return '${diff.inHours}시간 전';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes}분 전';
  } else {
    return '방금 전';
  }
}

String dateAgo(DateTime src, DateTime dst) {
  final diff = dst.difference(src);
  if (diff.inDays > 365) {
    return '${diff.inDays ~/ 365}년 전';
  } else if (diff.inDays > 30) {
    return '${diff.inDays ~/ 30}달 전';
  } else if (diff.inDays > 0) {
    return '${diff.inDays}일 전';
  } else {
    return '오늘';
  }
}

bool isSameDate(DateTime src, DateTime dst) => src.year == dst.year && src.month == dst.month && src.day == dst.day;
bool isNotSameDate(DateTime src, DateTime dst) => !isSameDate(src, dst);

DateTime endOfDay(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
final kEndOfToday = endOfDay(DateTime.now());
