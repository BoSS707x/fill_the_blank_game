import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('HomePage displays welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    expect(find.text('Welcome to the Fill the Blank Game!'), findsOneWidget);
  });

  testWidgets('HomePage has registration button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
      ),
    );

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
