import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/pages/counter_page.dart';

void main() {
  group('CounterPage Widget Tests - Initial State', () {
    testWidgets('should display title "計數器"', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.text('計數器'), findsOneWidget);
    });

    testWidgets('should display counter as "0" initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('should have a circular button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      // Button is now an IconButton inside a Container
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byKey(const Key('increment_button')), findsOneWidget);
    });

    testWidgets('should have counter_title key', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('counter_title')), findsOneWidget);
    });

    testWidgets('should have counter_display key', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('counter_display')), findsOneWidget);
    });

    testWidgets('should have increment_button key', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('increment_button')), findsOneWidget);
    });
  });
}
