import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_flutter/main.dart';

void main() {
  group('Multi-Device Tests', () {
    testWidgets('renders correctly on standard phone', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);

      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      expect(find.text('計數器'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('renders correctly on tablet', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(800, 1280);

      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      expect(find.text('計數器'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('renders correctly on large device', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.physicalSizeTestValue = const Size(540, 1080);

      await tester.pumpWidget(const CounterApp());
      await tester.pumpAndSettle();

      expect(find.text('計數器'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });
  });
}

