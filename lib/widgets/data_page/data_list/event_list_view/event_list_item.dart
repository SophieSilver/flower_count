import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/model/event_list.dart';
import 'package:flower_count/utils.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view/confirm_delete.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view/remove_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class EventListItem extends HookWidget {
  final int index;
  final EventEntry event;
  final bool _isDeleting;

  const EventListItem({super.key, required this.index, required this.event})
      : _isDeleting = false;

  EventListItem._deleted(EventListItem item)
      : index = item.index,
        event = item.event,
        _isDeleting = true;

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
            onPressed: _isDeleting
                ? null
                : () async {
                    final bool shouldDelete = await showDialog(
                            context: context,
                            builder: const ConfirmDelete().build) ??
                        false;

                    if (!shouldDelete || !context.mounted) {
                      return;
                    }

                    Provider.of<EventList>(context, listen: false)
                        .remove(index);
                    AnimatedList.of(context).removeItem(
                      index,
                      (context, animation) => RemoveAnimation(
                          animation: animation,
                          child: EventListItem._deleted(this)),
                      duration: Durations.medium4,
                    );
                  },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
    );
  }
}
