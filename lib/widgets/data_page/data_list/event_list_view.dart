import 'dart:collection';

import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view/event_list_item.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  final UnmodifiableListView<EventEntry> events;

  const EventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: this.events.indexed.map(
    //     (indexedEvent) {
    //       final (index, event) = indexedEvent;

    //       return EventListItem(index: index, event: event);
    //     },
    //   ).toList(),
    // );

    final items = this.events.indexed.map(
      (indexedEvent) {
        final (index, event) = indexedEvent;

        return EventListItem(
          index: index,
          event: event,
        );
      },
    ).toList();

    return ListView(
      children: items,
    );
  }
}

