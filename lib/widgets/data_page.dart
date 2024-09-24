import 'dart:io';

import 'package:flower_count/model/event_list.dart';
import 'package:flower_count/services/export_service.dart';
import 'package:flower_count/widgets/data_page/data_list.dart';
import 'package:flower_count/widgets/data_page/data_period_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  Widget _saveButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        final events = Provider.of<EventList>(context, listen: false).data;
        if (events != null) {
          ExportService.saveEventsToFile(events);
        }
      },
      child: const Text("Сохранить в файл"),
    );
  }

  Widget _shareButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        final events = Provider.of<EventList>(context, listen: false).data;
        if (events != null) {
          ExportService.shareEvents(events);
        }
      },
      child: const Text("Отправить"),
    );
  }

  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: Platform.isLinux
          ? [this._saveButton(context)]
          : [this._saveButton(context), this._shareButton(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: ChangeNotifierProvider<EventList>(
        // FIXME: We currently have 2 places where the default period is set
        create: (context) => EventList(period: PeriodOption.oneDay.period()),
        // using builder instead of child to capture the provider in the context to buttons
        builder: (context, _) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: PeriodPicker()),
            const Expanded(child: DataList()),
            _buttons(context),
          ],
        ),
      ),
    );
  }
}
