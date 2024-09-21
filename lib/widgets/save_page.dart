import 'package:flower_count/widgets/save_page/save_period_picker.dart';
import 'package:flutter/material.dart';



class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  SavePeriod value = SavePeriod.oneDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SavePeriodPicker(value: value)
      ],
    );
  }
}
