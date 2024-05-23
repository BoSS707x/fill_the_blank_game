import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('LoginPage displays login button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('LoginPage has username and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
  });
}
