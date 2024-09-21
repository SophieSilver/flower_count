import 'package:flower_count/widgets/save_page/save_period_picker.dart';
import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  SavePeriod _savePeriod = SavePeriod.oneDay;

  void _changeSavePeriod(SavePeriod newValue) {
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
          SavePeriodPicker(
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
                onPressed: () {},
                child: Text("Отправить"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
