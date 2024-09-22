import 'package:intl/intl.dart';

String formatDateTime(DateTime value) {
  final format = DateFormat("dd.MM.yyyy HH:mm:ss");

  return format.format(value);
}