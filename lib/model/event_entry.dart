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
