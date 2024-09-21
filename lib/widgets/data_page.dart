import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/data_page/save_period_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 120.0, bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PeriodPicker(
            value: this._savePeriod,
            onChanged: this._changeSavePeriod,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text("Сохранить как файл"),
              ),
              OutlinedButton(
                onPressed: () {
                  StorageService.retrieveEvents(period: Duration(days: 1))
                      .then((value) {
                    print(value);
                  });
                },
                child: Text("Отправить"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
