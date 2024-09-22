import 'package:sqflite/sqflite.dart';

const _dbPath = "flower_count.db";

class EventEntry {
  final int id;
  final DateTime dateTime;

  const EventEntry({required this.id, required this.dateTime});

  EventEntry.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        dateTime = DateTime.fromMillisecondsSinceEpoch(
            (map["timestamp"] as int) * 1000,
            isUtc: false);

  @override
  String toString() {
    return "{id: $id, dateTime: $dateTime}";
  }
}

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
    final db = await openDatabase(
      _dbPath,
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
