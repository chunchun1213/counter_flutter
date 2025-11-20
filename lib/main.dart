import 'package:flutter/material.dart';
import 'pages/counter_page.dart';

void main() {
  runApp(const CounterApp());
}

/// The main Counter app widget.
/// Sets up Material app configuration and routes to CounterPage.
class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CounterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
