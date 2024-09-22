import 'dart:convert';

import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/utils.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  static void shareEvents(Iterable<EventEntry> events) {
    final csvEvents = eventsToCsv(events);
    final csvBytes = utf8.encode(csvEvents);
    final fileName = "data-${DateTime.now().toIso8601String()}.csv";

    Share.shareXFiles(
      [XFile.fromData(csvBytes, mimeType: "text/csv", name: fileName)],
      fileNameOverrides: [fileName],
    );
  }

  static void saveEventsToFile(Iterable<EventEntry> events) {
    final csvEvents = eventsToCsv(events);
    final csvBytes = utf8.encode(csvEvents);
    final fileName = "data-${DateTime.now().toIso8601String()}.csv";
    
    final params = SaveFileDialogParams(data: csvBytes, fileName: fileName);
    FlutterFileDialog.saveFile(params: params);
  }
}
