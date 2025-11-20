import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/main.dart';

void main() {
  group('Counter App Integration Tests - Complete Flow', () {
    testWidgets('complete flow: launch app, tap button 3 times, verify count', (
      WidgetTester tester,
    ) async {
      // Start the app
      await tester.pumpWidget(const CounterApp());

      // Wait for app to settle
      await tester.pumpAndSettle();

      // Verify initial state
      expect(find.text('計數器'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      // Tap button first time
      final incrementButton = find.byKey(const Key('increment_button'));
      await tester.tap(incrementButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text('1'), findsOneWidget);

      // Tap button second time
      await tester.tap(incrementButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text('2'), findsOneWidget);

      // Tap button third time
      await tester.tap(incrementButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('UI responds quickly to button taps', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      final incrementButton = find.byKey(const Key('increment_button'));

      final stopwatch = Stopwatch()..start();
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
      stopwatch.stop();

      // UI update should complete within 100ms
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });
  });
}
