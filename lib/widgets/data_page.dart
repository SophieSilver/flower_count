import 'dart:io';

import 'package:flower_count/services/export_service.dart';
import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/data_page/data_list.dart';
import 'package:flower_count/widgets/data_page/data_period_picker.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  PeriodOption _savePeriod = PeriodOption.oneDay;

  void _changeSavePeriod(PeriodOption newValue) {
    setState(() {
      this._savePeriod = newValue;
    });
  }

  Widget _saveButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        StorageService.retrieveEvents(
          period: this._savePeriod.period(),
        ).then((events) {
          ExportService.saveEventsToFile(events);
        });
      },
      child: const Text("Сохранить в файл"),
    );
  }

  Widget _shareButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        StorageService.retrieveEvents(
          period: this._savePeriod.period(),
        ).then((events) {
          ExportService.shareEvents(events);
        });
      },
      child: const Text("Отправить"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = Platform.isLinux
        ? [this._saveButton(context)]
        : [this._saveButton(context), this._shareButton(context)];

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: PeriodPicker(
              value: this._savePeriod,
              onChanged: this._changeSavePeriod,
            ),
          ),
          Expanded(
            child: DataList(period: this._savePeriod.period()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buttons,
          ),
        ],
      ),
    );
  }
}
