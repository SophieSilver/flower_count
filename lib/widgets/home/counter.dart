import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatelessWidget {
  final void Function() onPress;

  const Counter({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: IconButton.filled(
        onPressed: () {
          HapticFeedback.vibrate();
          this.onPress();
        },
        highlightColor: colorScheme.inversePrimary,
        icon: Icon(Icons.add),
        tooltip: "Создать новое событие",
        enableFeedback: true,
        iconSize: 72,
      ),
    );
  }
}
