import 'package:flutter/material.dart';

void main() => runApp(const MinipressApp());

class MinipressApp extends StatelessWidget {
  const MinipressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MiniPress',
      home: Scaffold(body: Center(child: Text('MiniPress'))),
    );
  }
}
