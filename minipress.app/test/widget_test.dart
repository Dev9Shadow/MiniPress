import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minipress_app/main.dart';

void main() {
  testWidgets('MiniPress app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MinipressApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
