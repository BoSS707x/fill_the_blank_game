import 'package:flutter_test/flutter_test.dart';
import 'package:fill_the_blank_game/pages/registration_page.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('RegistrationPage displays registration button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegistrationPage(),
      ),
    );

    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('RegistrationPage has all required fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegistrationPage(),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(3)); // Assuming 3 fields: username, email, password
  });
}
