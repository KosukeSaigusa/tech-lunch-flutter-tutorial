import 'package:flutter/material.dart';

import 'features/counter/ui/counter_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Lunch Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(title: 'Counter Page'),
    );
  }
}
