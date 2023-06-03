import 'package:intl/intl.dart';

String formatDate({required String date, String? format}) {
  return DateFormat(format ?? 'd MMM y').format(DateTime.parse(date));
}

String formatDateTime({String? date, String? format}) {
  return DateFormat(format ?? 'hh:mm a').format(DateTime.now());
}

String formatDayName({String? date, String? format}) {
  return DateFormat(format ?? 'EEEE').format(DateTime.parse(date!));
}
