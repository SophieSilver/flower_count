import 'package:flutter/material.dart';

enum SavePeriod {
  oneDay,
  sevenDays,
  allTime,
}

class SavePeriodPicker extends StatelessWidget {
  final SavePeriod value;
  const SavePeriodPicker({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Период: "),
        DropdownButton(
          onChanged: (value) {},
          value: this.value,
          items: [
            DropdownMenuItem(
              value: SavePeriod.oneDay,
              child: Text("1 день"),
            ),
            DropdownMenuItem(
              value: SavePeriod.sevenDays,
              child: Text("7 дней"),
            ),
            DropdownMenuItem(
              value: SavePeriod.allTime,
              child: Text("всё время"),
            ),
          ],
        ),
      ],
    );
  }
}
