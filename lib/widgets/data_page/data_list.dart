import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/data_page/event_list_view.dart';
import 'package:flutter/material.dart';

class DataList extends StatefulWidget {
  final Duration? period;

  const DataList({super.key, this.period});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<EventEntry>? _eventList;

  void _setEventList(List<EventEntry>? value) {
    setState(() {
      this._eventList = value;
    });
  }

  void _fetchEventList() async {
    this._setEventList(null);
    final newList = (await Future.delayed(Duration(seconds: 2),
            () => StorageService.retrieveEvents(period: this.widget.period)))
        .toList();
    this._setEventList(newList);
  }

  @override
  void initState() {
    super.initState();
    this._fetchEventList();
  }

  @override
  void didUpdateWidget(covariant DataList oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._fetchEventList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.secondaryContainer, width: 2.0),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: colorScheme.secondaryContainer),
              ),
            ),
            child: Text(
              "Количество: ${this._eventList?.length.toString() ?? ""}",
              style: textTheme.labelLarge,
              textAlign: TextAlign.start,
            ),
          ),
          this._eventList == null
              ? Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                )
              : EventListView(events: this._eventList!),
        ],
      ),
    );
  }
}
