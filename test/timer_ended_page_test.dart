import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/timer_ended_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('TimerEndedPage displays message', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TimerEndedPage(score: 100, timeLeft: 0, username: 'test_user'),
      ),
    );

    expect(find.text('Time\'s Up!'), findsOneWidget);
    expect(find.text('Score: 100'), findsOneWidget);
  });

  testWidgets('TimerEndedPage displays username', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TimerEndedPage(score: 100, timeLeft: 0, username: 'test_user'),
      ),
    );

    expect(find.text('test_user'), findsOneWidget);
  });
}
