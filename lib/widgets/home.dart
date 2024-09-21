import 'package:flower_count/widgets/home/counter.dart';
import 'package:flower_count/widgets/home/save_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Counter(onPress: () {})),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: SaveButton(onPress: () {
            Navigator.of(context).pushNamed("/save");
          }),
        ),
      ],
    );
  }
}
