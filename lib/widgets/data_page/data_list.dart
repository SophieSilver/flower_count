import 'dart:collection';

import 'package:flower_count/model/event_entry.dart';
import 'package:flower_count/model/event_list.dart';
import 'package:flower_count/widgets/data_page/data_list/event_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataList extends StatelessWidget {
  const DataList({super.key});

  Widget _headerWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border(
          bottom: BorderSide(color: colorScheme.secondaryContainer),
        ),
      ),
      child: Consumer<EventList>(
        builder: (context, eventList, _) => Text(
          "Всего: ${eventList.data?.length.toString() ?? ""}",
          style: textTheme.labelLarge?.copyWith(fontSize: 16.0),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget _tableBodyLoading(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _tableBodyData(
    BuildContext context,
    UnmodifiableListView<EventEntry> eventListData,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        child: EventListView(
          events: eventListData,
        ),
      ),
    );
  }

  Widget _tableBodyWidget(BuildContext context) {
    return Consumer<EventList>(
      builder: (context, eventList, _) {
        if (eventList.data == null) {
          return _tableBodyLoading(context);
        }
        return _tableBodyData(context, eventList.data!);
      },
    );
  }

  Widget _tableWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        this._headerWidget(context),
        this._tableBodyWidget(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.secondaryContainer, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0), // 20 - 2 pixels of border
        clipBehavior: Clip.antiAlias,
        child: this._tableWidget(context),
      ),
    );
  }
}
