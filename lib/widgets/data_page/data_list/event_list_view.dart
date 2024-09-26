import 'dart:collection';

import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view/event_list_item.dart';
import 'package:flutter/material.dart';

class EventListView extends StatefulWidget {
  final UnmodifiableListView<EventEntry> events;

  const EventListView({super.key, required this.events});

  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  late final int initialLen;
  
  @override
  void initState() {
    initialLen = this.widget.events.length;
    super.initState();
  }

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

    final items = this.widget.events.indexed.map(
      (indexedEvent) {
        final (index, event) = indexedEvent;

        return EventListItem(
          index: index,
          event: event,
        );
      },
    ).toList();

    // return ListView(
    //   children: items,
    // );

    return AnimatedList(
      itemBuilder: (context, index, animation) => items[index],
      initialItemCount: initialLen,
    );
  }
}

