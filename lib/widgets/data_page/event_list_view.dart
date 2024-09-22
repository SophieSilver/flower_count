import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/utils.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  final List<EventEntry> events;
  final void Function(int) onDelete;

  const EventListView(
      {super.key, required this.events, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      children: this.events.indexed.map(
        (indexedEvent) {
          final (index, event) = indexedEvent;

          return Container(
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
                  onPressed: () => this.onDelete(index),
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
