import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('SettingsPage displays save button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingsPage(),
      ),
    );

    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('SettingsPage has toggle switches', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingsPage(),
      ),
    );

    expect(find.byType(Switch), findsWidgets);
  });
}
