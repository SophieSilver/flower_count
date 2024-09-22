import 'package:flower_count/services/storage_service.dart';
import 'package:flower_count/utils.dart';
import 'package:flower_count/widgets/app_scaffold.dart';
import 'package:flower_count/widgets/home.dart';
import 'package:flower_count/widgets/data_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  // TODO: remove
  await fillTestData();

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
        "/data": (context) => AppScaffold(
              title: "Данные",
              child: DataPage(),
            ),
      },
    );
  }
}
