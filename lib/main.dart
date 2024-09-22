import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/widgets/app_scaffold.dart';
import 'package:flower_count/widgets/home.dart';
import 'package:flower_count/widgets/data_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

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
        "/": (context) => const AppScaffold(child: Home()),
        "/data": (context) => const AppScaffold(
              title: "Данные",
              child: DataPage(),
            ),
      },
    );
  }
}
