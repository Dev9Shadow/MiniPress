import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MinipressApp());

class MinipressApp extends StatelessWidget {
  const MinipressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiniPress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
