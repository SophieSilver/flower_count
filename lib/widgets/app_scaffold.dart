import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  final String? title;
  const AppScaffold({super.key, required this.child, this.title});
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer.withOpacity(1.0),
        foregroundColor: colorScheme.onPrimaryContainer.withOpacity(1.0),
        shadowColor: Colors.black,
        title: Text(this.title ?? "Flower Count"),
        scrolledUnderElevation: 0.0,
      ),
      body: child,
    );
  }
}
