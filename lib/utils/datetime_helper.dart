import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) => DateFormat('yyyy-MM-dd').format(dateTime);

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

DateTime endOfDay(DateTime dateTime) => DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
final kEndOfToday = endOfDay(DateTime.now());
