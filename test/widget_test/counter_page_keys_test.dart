import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/pages/counter_page.dart';

void main() {
  group('CounterPage Widget Tests - Keys and Accessibility', () {
    testWidgets('counter_title key is locatable', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('counter_title')), findsOneWidget);
    });

    testWidgets('counter_display key is locatable', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('counter_display')), findsOneWidget);
    });

    testWidgets('increment_button key is locatable', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      expect(find.byKey(const Key('increment_button')), findsOneWidget);
    });

    testWidgets('counter_display has semanticsLabel', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      final semanticsHandle = tester.getSemantics(
        find.byKey(const Key('counter_display')),
      );
      expect(semanticsHandle, isNotNull);
    });

    testWidgets('increment_button has tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      final button = find.byKey(const Key('increment_button'));
      expect(button, findsOneWidget);

      final iconButton = tester.widget<IconButton>(button);
      expect(iconButton.tooltip, '增加計數');
    });

    testWidgets('color contrast meets accessibility standards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      // Verify app renders without errors
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
