import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/level_1.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Level 1 displays first question', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    expect(find.text('The coldest season is ______'), findsOneWidget);
  });

  testWidgets('Submit button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('Keyboard buttons are present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    expect(find.text('R'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
  });

  testWidgets('Check answer feedback', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    await tester.enterText(find.byType(TextField), 'winter');
    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Correct! 🎉'), findsOneWidget);
  });
}
