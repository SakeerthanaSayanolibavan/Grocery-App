import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_app/main.dart';

void main() {
  testWidgets('Grocery app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GroceryApp());

    // Verify that our home screen banner or title is found.
    expect(find.text('Fresh Vegetables'), findsOneWidget);
  });
}