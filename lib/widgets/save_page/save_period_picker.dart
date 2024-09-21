import 'package:flutter/material.dart';

enum SavePeriod {
  oneDay,
  sevenDays,
  allTime,
}

class SavePeriodPicker extends StatelessWidget {
  final SavePeriod value;
  final void Function(SavePeriod) onChanged;

  const SavePeriodPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Период:", style: textStyle),
        SizedBox(width: 20.0),
        DropdownButton(
          onChanged: (newVaalue) {
            if (newVaalue != null) {
              onChanged(newVaalue);
            }
          },
          value: this.value,
          style: textStyle,
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
