import 'package:calendar_test_project/pages/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ru', 'RU'), // Устанавливаем русскую локализацию
      supportedLocales: [Locale('ru', 'RU')],
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}
