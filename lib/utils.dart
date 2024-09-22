import 'package:flower_count/services/storage_service.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime value) {
  final format = DateFormat("dd.MM.yyyy HH:mm:ss");

  return format.format(value);
}

Future<void> fillTestData() async {
  DateTime now = DateTime.timestamp();

  for (int i = 0; i < 1000; i++) {
    StorageService.storeNewEvent(now.subtract(Duration(hours: i, minutes: 5 * i, seconds: 7 * i)));
  }
}
