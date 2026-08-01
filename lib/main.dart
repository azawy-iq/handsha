import 'package:flutter/material.dart';
import 'home_screen.dart'; // استدعاء ملف الشاشة الجديدة

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هندسها',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1B1B1B),
        primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              fontFamily: 'Tajawal',
            ),
      ),
      home: const MainHomeScreen(), // الشاشة الرئيسية
    );
  }
}
