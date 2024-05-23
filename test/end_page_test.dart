import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/end_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('EndPage displays score and username', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EndPage(score: 100, timeLeft: 10, username: 'test_user'),
      ),
    );

    expect(find.text('Score: 100'), findsOneWidget);
    expect(find.text('test_user'), findsOneWidget);
  });

  testWidgets('EndPage displays correct time left', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EndPage(score: 100, timeLeft: 10, username: 'test_user'),
      ),
    );

    expect(find.text('Time Left: 10'), findsOneWidget);
  });
}
