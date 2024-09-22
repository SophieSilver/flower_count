import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  static void shareEvents(Iterable<EventEntry> events) {
    final csvEvents = eventsToCsv(events);
    final csvBytes = utf8.encode(csvEvents);
    final fileName = getDefaultFilename();

    Share.shareXFiles(
      [XFile.fromData(csvBytes, mimeType: "text/csv", name: fileName)],
      fileNameOverrides: [fileName],
    );
  }

  static void saveEventsToFile(Iterable<EventEntry> events) async {
    final csvEvents = eventsToCsv(events);
    final fileName = getDefaultFilename();
    final isMobile = Platform.isAndroid || Platform.isIOS;

    final savePath = await FilePicker.platform.saveFile(
      initialDirectory: (await getDownloadsDirectory())?.path,
      fileName: fileName,
      bytes: isMobile ? utf8.encode(csvEvents) : null,
    );

    if (savePath == null || Platform.isAndroid || Platform.isIOS) {
      return;
    }

    final saveFile = File(savePath);
    await saveFile.writeAsString(csvEvents, encoding: utf8);
  }
}
