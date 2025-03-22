// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trashecomate/widgets/custom_text_field.dart';
import 'package:trashecomate/widgets/custom_button.dart';

void main() {
  testWidgets('CustomButton displays correct text and responds to tap', (WidgetTester tester) async {
    // Create a key for the button
    final buttonKey = Key('custom_button');

    // Build the CustomButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            key: buttonKey,
            text: 'Click Me',
            onPressed: () {},
          ),
        ),
      ),
    );

    // Verify that the button displays the correct text
    expect(find.text('Click Me'), findsOneWidget);

    // Tap the button and trigger a frame
    await tester.tap(find.byKey(buttonKey));
    await tester.pump(); // Rebuild the widget after the state has changed
  });

  testWidgets('CustomTextField displays hint text and allows input', (WidgetTester tester) async {
    // Build the CustomTextField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(hintText: 'Enter your name'),
        ),
      ),
    );

    // Verify that the hint text is displayed
    expect(find.text('Enter your name'), findsOneWidget);

    // Enter text into the text field
    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the text field contains the entered text
    expect(find.text('John Doe'), findsOneWidget);
  });
}