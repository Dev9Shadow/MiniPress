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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: const CardTheme(elevation: 2),
        dividerTheme: const DividerThemeData(thickness: 1),
      ),
      home: const HomeScreen(),
    );
  }
}
