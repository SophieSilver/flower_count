import 'dart:collection';

import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/model/event_list.dart';
import 'package:flower_count/utils.dart';
import 'package:flower_count/widgets/data_page/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListView extends StatelessWidget {
  final UnmodifiableListView<EventEntry> events;

  const EventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      children: this.events.indexed.map(
        (indexedEvent) {
          final (index, event) = indexedEvent;

          return Container(
            key: Key(event.id.toString()),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0)
                .copyWith(right: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.secondaryContainer,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDateTime(event.dateTime)),
                IconButton.outlined(
                  onPressed: () async {
                    final bool shouldDelete = await showDialog(
                            context: context,
                            builder: const ConfirmDelete().build) ??
                        false;
                    if (!shouldDelete || !context.mounted) {
                      return;
                    }
                    Provider.of<EventList>(context, listen: false)
                        .remove(index);
                  },
                  icon: const Icon(Icons.delete_forever),
                )
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
