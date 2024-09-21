import 'package:flower_count/widgets/app_scaffold.dart';
import 'package:flower_count/widgets/home.dart';
import 'package:flower_count/widgets/save_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flower Count',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => AppScaffold(child: Home()),
        "/save": (context) => AppScaffold(
              title: "Сохранить",
              child: SavePage(),
            ),
      },
    );
  }
}
