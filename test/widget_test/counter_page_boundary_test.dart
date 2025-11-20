import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/main.dart';

void main() {
  group('Boundary Condition Tests', () {
    testWidgets('handles rapid button taps (100 taps)', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      final button = find.byKey(const Key('increment_button'));

      // Rapid tap 100 times
      for (int i = 0; i < 100; i++) {
        await tester.tap(button);
      }
      await tester.pumpAndSettle();

      // Should show 100
      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('app remains functional after many interactions', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // Tap button multiple times
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      // Continue using app
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);

      // Verify button still works
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('counter increments correctly up to large numbers', (WidgetTester tester) async {
      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      // Tap multiple times to test large numbers
      for (int i = 0; i < 50; i++) {
        await tester.tap(find.byKey(const Key('increment_button')));
      }
      await tester.pumpAndSettle();

      expect(find.text('50'), findsOneWidget);
    });
  });
}

