import 'package:async/async.dart';
import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/data_page/confirm_delete.dart';
import 'package:flower_count/widgets/data_page/event_list_view.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  final Duration? period;

  const DataList({super.key, this.period});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  CancelableOperation<Iterable<EventEntry>>? _currentListCallback;
  List<EventEntry>? _eventList;

  void _setEventList(List<EventEntry>? value) {
    if (!this.mounted) {
      return;
    }

    setState(() {
      this._eventList = value;
    });
  }

  void _fetchEventList() async {
    await this._currentListCallback?.cancel();
    this._currentListCallback = null;

    this._setEventList(null);
    final newListCallback = CancelableOperation.fromFuture(
      StorageService.retrieveEvents(period: this.widget.period),
    );

    this._currentListCallback = newListCallback;
    final newList = (await newListCallback.value).toList();
    this._setEventList(newList);
  }

  void _deleteEvent(int index) async {
    bool shouldDelete = await showDialog(
          context: this.context,
          builder: const ConfirmDelete().build,
        ) ??
        false;

    if (!this.mounted || !shouldDelete) {
      return;
    }

    EventEntry? removed;
    this.setState(() {
      removed = this._eventList?.removeAt(index);
    });

    if (removed == null) {
      return;
    }

    StorageService.deleteEvent(removed!.id);
  }

  @override
  void initState() {
    super.initState();
    this._fetchEventList();
  }

  @override
  void didUpdateWidget(covariant DataList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.period == oldWidget.period) {
      return;
    }
    this._fetchEventList();
  }

  @override
  void dispose() {
    this._currentListCallback?.cancel();
    this._currentListCallback = null;

    super.dispose();
  }

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
      child: Text(
        "Всего: ${this._eventList?.length.toString() ?? ""}",
        style: textTheme.labelLarge?.copyWith(fontSize: 16.0),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _eventListWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (this._eventList == null) {
      return Expanded(
        child: Container(
          color: colorScheme.surfaceContainerLowest,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return Expanded(
      child: Container(
        color: colorScheme.surfaceContainerLowest,
        child: EventListView(
          events: this._eventList!,
          onDelete: this._deleteEvent,
        ),
      ),
    );
  }

  Widget _tableWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        this._headerWidget(context),
        this._eventListWidget(context),
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
