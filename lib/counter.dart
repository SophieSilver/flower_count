import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        shadowColor: Colors.black,
        title: Text("Flower Counter"),
      ),
      body: Center(
        child: IconButton.filled(
          onPressed: () {
              HapticFeedback.vibrate();
          },
          highlightColor: colorScheme.inversePrimary,
          icon: Icon(Icons.add),
          splashColor: colorScheme.tertiary,
          enableFeedback: true,
          iconSize: 64,
        ),
      ),
    );
  }
}
