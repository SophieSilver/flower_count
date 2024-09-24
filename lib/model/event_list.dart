import 'dart:collection';

import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/services/storage_service.dart';
import 'package:flutter/material.dart';

class EventList with ChangeNotifier {
  bool disposed = false;
  List<EventEntry>? _data;
  Duration? _period;

  EventList({Duration? period}) {
    _period = period;
    _asyncRetrieveData();
  }

  void setPeriod(Duration? period) {
    _period = period;
    _data = null;
    _asyncRetrieveData();
  }

  void _asyncRetrieveData() async {
    _data = (await StorageService.retrieveEvents(period: _period)).toList();
    if (disposed) {
      return;
    }
    notifyListeners();
  }

  UnmodifiableListView<EventEntry>? get data =>
      _data == null ? null : UnmodifiableListView(_data!);

  Duration? get period => _period;

  void add(DateTime event) async {
    await StorageService.storeNewEvent(event);
    if (disposed) {
      return;
    }
    notifyListeners();
  }

  void remove(int index) async {
    if (_data == null) {
      return;
    }

    final idAtIndex = _data!.removeAt(index).id;
    notifyListeners();
    await StorageService.deleteEvent(idAtIndex);
  }

  @override
  void dispose() {
    this.disposed = true;
    this._data = null;
    super.dispose();
  }
}
