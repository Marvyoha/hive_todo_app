import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/homepage.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('myBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0)),
      home: const Scaffold(
        body: HomePage(),
      ),
    );
  }
}
