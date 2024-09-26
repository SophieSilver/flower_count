import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/home/counter/click_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Нажмите, чтобы добавить событие",
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.secondary.withOpacity(0.7),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Material(
          child: Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: colorScheme.primaryContainer,
            ),
            child: IconButton(
              onPressed: () {
                HapticFeedback.vibrate();
                StorageService.storeNewEvent(DateTime.timestamp());
                Provider.of<ClickNotifier>(context, listen: false).notify();
              },
              highlightColor: colorScheme.onPrimaryContainer.withOpacity(0.3),
              icon: const Icon(Icons.add),
              enableFeedback: true,
              iconSize: 72,
            ),
          ),
        ),
      ],
    );
  }
}
