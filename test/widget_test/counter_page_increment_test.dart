import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/pages/counter_page.dart';

void main() {
  group('CounterPage Widget Tests - Increment', () {
    testWidgets('should display "1" after clicking button once', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should display "3" after clicking button three times', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('text style should remain consistent after increment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: CounterPage()));

      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      final textWidget = find.byKey(const Key('counter_display'));
      expect(textWidget, findsOneWidget);

      // Verify it's still a Text widget
      final widget = tester.widget<Text>(textWidget);
      expect(widget.style?.fontSize, 72);
      expect(widget.style?.fontWeight, FontWeight.w700);
    });
  });
}
