import 'package:counter_ui_practice/widgets/counter_actions.dart';
import 'package:counter_ui_practice/widgets/counter_circle.dart';
import 'package:counter_ui_practice/widgets/counter_header.dart';
import 'package:counter_ui_practice/widgets/tip_card.dart';
import 'package:counter_ui_practice/widgets/welcome_section.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  void _decrementCounter() {
    if (_counter == 0) {
      _showCounterMessage('Counter cannot go below 0');
      return;
    }

    setState(() {
      _counter--;
    });
    _saveCounter();
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    _saveCounter();
  }

  void _showCounterMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final horizontalPadding = width * 0.06;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.09),
        child: CounterHeader(title: 'Counter App', count: _counter),
      ),
      backgroundColor: const Color.fromRGBO(248, 246, 253, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              children: [
                const WelcomeSection(),
                SizedBox(height: height * 0.03),

                CounterCircle(count: _counter),

                SizedBox(height: height * 0.025),

                CounterActions(
                  decrementFunction: _decrementCounter,
                  incrementFunction: _incrementCounter,
                  resetFunction: _resetCounter,
                  isResetDisabled: _counter == 0,
                ),

                SizedBox(height: height * 0.03),

                TipCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
