import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/model/event_list.dart';
import 'package:flower_count/utils.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view/confirm_delete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListItem extends StatelessWidget {
  final int index;
  final EventEntry event;

  const EventListItem({super.key, required this.index, required this.event});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
          IconButton(
            onPressed: () async {
              final bool shouldDelete = await showDialog(
                      context: context, builder: const ConfirmDelete().build) ??
                  false;
              if (!shouldDelete || !context.mounted) {
                return;
              }
              Provider.of<EventList>(context, listen: false).remove(index);
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
    );
  }
}
