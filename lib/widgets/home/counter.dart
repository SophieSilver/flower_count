import 'package:flower_count/widgets/home/counter/click_notifier.dart';
import 'package:flower_count/widgets/home/counter/counter_button.dart';
import 'package:flower_count/widgets/home/counter/on_click_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClickNotifier(),
      builder: (context, _) => Stack(
        children: [
          const Center(child: CounterButton()),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(50.0),
            child: const OnClickPopUp(),
          ),
        ],
      ),
    );
  }
}
