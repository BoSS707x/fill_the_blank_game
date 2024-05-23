import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/intro_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('IntroPage displays intro text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IntroPage(),
      ),
    );

    expect(find.text('Get Ready!'), findsOneWidget);
  });

  testWidgets('IntroPage has start button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: IntroPage(),
      ),
    );

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
