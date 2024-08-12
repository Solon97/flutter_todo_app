import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('taskBox');
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
          primaryColor: Colors.yellow,
          scaffoldBackgroundColor: Colors.yellow[200],
          appBarTheme:
              const AppBarTheme(color: Colors.yellow, centerTitle: true)),
    );
  }
}
