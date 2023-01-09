import 'package:date_format/date_format.dart';

DateTime timeToDate(time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}

String timeToDateFormat(time) {
  return formatDate(timeToDate(time), [yyyy, '年', mm, '月', dd, '日']);
}
