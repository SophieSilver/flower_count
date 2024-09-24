import 'package:flower_count/model/event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class PeriodPicker extends StatefulWidget {
  const PeriodPicker({super.key});

  @override
  State<PeriodPicker> createState() => _PeriodPickerState();
}

class _PeriodPickerState extends State<PeriodPicker> {
  PeriodOption _option = PeriodOption.oneDay;

  void _setOption(PeriodOption newOption) {
    setState(() {
      _option = newOption;
    });
  }

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
          onChanged: (newValue) {
            if (newValue != null) {
              _setOption(newValue);
              Provider.of<EventList>(context, listen: false).setPeriod(newValue.period());
            }
          },
          value: _option,
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
