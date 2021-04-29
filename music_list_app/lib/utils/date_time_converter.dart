
import 'package:cloud_firestore/cloud_firestore.dart';

DateTime toDateTime(dynamic data) {
  if (data == null || !(data is Timestamp)) {
    return null;
  }
  final Timestamp ts = data;
  return DateTime.fromMillisecondsSinceEpoch(ts.millisecondsSinceEpoch);
}

String toTimeSeconds(int runtime)
{
  final _seconds = runtime % 60;
  final _minutes = runtime ~/ 60;
  final _fill = _seconds > 9 ? ":" : ":0";
  return _minutes.toString() + _fill + _seconds.toString();
}
