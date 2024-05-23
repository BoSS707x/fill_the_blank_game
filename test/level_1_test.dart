import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fill_the_blank_game/pages/level_1.dart';

void main() {
  testWidgets('Check if level_1 widget builds correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    // Check if the app bar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Check if the initial level is displayed correctly
    expect(find.text('The coldest season is ______'), findsOneWidget);
  });

  testWidgets('Submit button functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    // Check if the Submit button is present
    expect(find.text('Submit'), findsOneWidget);

    // Tap the Submit button
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // Verify feedback after tapping the button
    expect(find.text('Incorrect, try again!'), findsOneWidget);
  });

  testWidgets('Check if keyboard buttons work', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FillTheBlankWidget(registeredUsername: 'test_user'),
      ),
    );

    // Tap the first letter button
    await tester.tap(find.text('R'));
    await tester.pump();

    // Verify if the letter is added to the answer controller
    expect(find.text('R'), findsOneWidget);
  });
}
