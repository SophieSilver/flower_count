import 'dart:io';

import 'package:flower_count/event_entry.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const _dbPath = "flower_count.db";

class UnknownDatabaseVersionException implements Exception {
  @override
  String toString() {
    return "tried to create a database with an unknown version";
  }
}

Future<void> _onConfigure(Database db) async {
  await db.rawQuery("PRAGMA journal_mode=WAL");
  await db.execute("PRAGMA foreign_keys=ON");
}

Future<void> _onCreate(Database db, int version) async {
  if (version != 1) {
    throw UnknownDatabaseVersionException();
  }

  await db.execute("""--sql
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY,
        timestamp INT
      );""");

  await db.execute(
      "CREATE INDEX IF NOT EXISTS event_timestamp_index ON events (timestamp);");
}

class StorageService {
  static late Database _db;

  static Future<void> init() async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      databaseFactory = databaseFactoryFfi;
    }

    var path = _dbPath;
    if (!Platform.isAndroid && !Platform.isIOS) {
      path = join((await getApplicationSupportDirectory()).path, _dbPath);
    }

    final db = await openDatabase(
      path,
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );

    StorageService._db = db;
  }

  static Future<void> storeNewEvent(DateTime event) async {
    final timestamp = event.millisecondsSinceEpoch ~/ 1000;

    await _db.insert("events", {"timestamp": timestamp});
  }

  static Future<Iterable<EventEntry>> retrieveEvents({
    Duration? period,
    int? offset,
    int? limit,
  }) async //
  {
    final int now = DateTime.timestamp().millisecondsSinceEpoch ~/ 1000;
    final entries = await _db.query("events",
        columns: ["id", "timestamp"],
        where: period == null ? null : "? - timestamp <= ?",
        whereArgs: period == null ? null : [now, period.inSeconds],
        orderBy: "timestamp ASC",
        limit: limit,
        offset: offset);

    return entries.map((entryMap) => EventEntry.fromMap(entryMap));
  }

  static Future<void> deleteEvent(int id) async {
    await _db.delete("events", where: "id = ?", whereArgs: [id]);
  }
}
