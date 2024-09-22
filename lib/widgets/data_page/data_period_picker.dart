import 'package:flutter/material.dart';

enum PeriodOption {
  oneDay,
  sevenDays,
  allTime;

  Duration? period() {
    switch (this) {
      case PeriodOption.oneDay:
        return const Duration(days: 1);
      case PeriodOption.sevenDays:
        return const Duration(days: 7);
      case PeriodOption.allTime:
        return null;
    }
  }
}

class PeriodPicker extends StatelessWidget {
  final PeriodOption value;
  final void Function(PeriodOption) onChanged;

  const PeriodPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Период:", style: textStyle),
        const SizedBox(width: 20.0),
        DropdownButton(
          onChanged: (newVaalue) {
            if (newVaalue != null) {
              onChanged(newVaalue);
            }
          },
          // padding: EdgeInsets.all(0.0),
          
          value: this.value,
          style: textStyle,
          items: const [
            DropdownMenuItem(
              value: PeriodOption.oneDay,
              child: Text("1 день"),
            ),
            DropdownMenuItem(
              value: PeriodOption.sevenDays,
              child: Text("7 дней"),
            ),
            DropdownMenuItem(
              value: PeriodOption.allTime,
              child: Text("всё время"),
            ),
          ],
        ),
      ],
    );
  }
}
