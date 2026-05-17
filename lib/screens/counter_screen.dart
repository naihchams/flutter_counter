import 'package:counter_ui_practice/widgets/counter_actions.dart';
import 'package:counter_ui_practice/widgets/counter_circle.dart';
import 'package:counter_ui_practice/widgets/counter_header.dart';
import 'package:counter_ui_practice/widgets/tip_card.dart';
import 'package:counter_ui_practice/widgets/welcome_section.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  bool _allowNegative = true;
  int _stepValue = 1;
  int _defaultValue = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
    _loadHistory();
  }

  Future<void> _initialize() async {
    await _loadSettings();
    await _loadCounter();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _allowNegative = prefs.getBool('allowNegative') ?? true;
      _stepValue = prefs.getInt('stepValue') ?? 1;
      _defaultValue = prefs.getInt('defaultValue') ?? 0;
    });
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? _defaultValue;
    });
  }

  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter += _stepValue;
      _addHistoryItem('increment');
    });

    _saveCounter();
  }

  void _decrementCounter() {
    if (!_allowNegative && _counter - _stepValue < 0) {
      _showCounterMessage('Counter cannot go below 0');
      return;
    }

    setState(() {
      _counter -= _stepValue;
      _addHistoryItem('decrement');
    });

    _saveCounter();
  }

  void _resetCounter() {
    if (_counter == _defaultValue) return;

    setState(() {
      _counter = _defaultValue;
      _addHistoryItem('reset');
    });

    _saveCounter();
  }

  void _showCounterMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  List<Map<String, dynamic>> _history = [];

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString('counter_history');

    if (historyString == null) return;

    setState(() {
      _history = List<Map<String, dynamic>>.from(jsonDecode(historyString));
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('counter_history', jsonEncode(_history));
  }

  void _addHistoryItem(String type) {
    _history.insert(0, {
      'type': type,
      'value': _counter,
      'createdAt': DateTime.now().toIso8601String(),
    });

    _saveHistory();
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
        child: CounterHeader(
          title: 'Counter App',
          count: _counter,
          onReturnedFromSettings: () async {
            _loadSettings();
            _loadCounter();
          },
        ),
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
                  isResetDisabled: _counter == _defaultValue,
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
