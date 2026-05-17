import 'package:counter_ui_practice/widgets/counter_actions.dart';
import 'package:counter_ui_practice/widgets/counter_circle.dart';
import 'package:counter_ui_practice/widgets/counter_header.dart';
import 'package:counter_ui_practice/widgets/tip_card.dart';
import 'package:counter_ui_practice/widgets/welcome_section.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++; // This change triggers a UI rebuild
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--; // This change triggers a UI rebuild
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0; // This change triggers a UI rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CounterHeader(title: 'Counter App'),
      ),
      backgroundColor: Color.fromRGBO(248, 246, 253, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                WelcomeSection(),
                SizedBox(height: 25),
                CounterCircle(count: _counter),
                SizedBox(height: 20),
                CounterActions(
                  decrementFunction: _decrementCounter,
                  incrementFunction: _incrementCounter,
                  resetFunction: _resetCounter,
                ),
                SizedBox(height: 30),
                TipCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
