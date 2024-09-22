import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatelessWidget {
  final void Function() onPress;

  const Counter({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
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
          IconButton.filled(
            onPressed: () {
              HapticFeedback.vibrate();
              this.onPress();
            },
            highlightColor: colorScheme.inversePrimary,
            icon: const Icon(Icons.add),
            tooltip: "Создать новое событие",
            enableFeedback: true,
            iconSize: 72,
          ),
        ],
      ),
    );
  }
}
