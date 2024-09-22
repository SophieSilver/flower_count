import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/home/counter.dart';
import 'package:flower_count/widgets/home/data_button.dart';
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
        Expanded(child: Counter(onPress: () {
          StorageService.storeNewEvent(DateTime.timestamp());
        })),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: DataButton(onPress: () {
            Navigator.of(context).pushNamed("/data");
          }),
        ),
      ],
    );
  }
}
