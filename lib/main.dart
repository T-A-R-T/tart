import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TartApp());
}

class TartApp extends StatelessWidget {
  const TartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}