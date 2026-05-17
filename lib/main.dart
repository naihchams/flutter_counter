import 'package:counter_ui_practice/widgets/counter_circle.dart';
import 'package:counter_ui_practice/widgets/counter_header.dart';
import 'package:counter_ui_practice/widgets/tip_card.dart';
import 'package:counter_ui_practice/widgets/welcome_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Counter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        child: CounterHeader(title: widget.title),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(230, 223, 249, 1),
                          ),
                          child: IconButton(
                            onPressed: _decrementCounter,
                            icon: Icon(Icons.remove_rounded),
                            iconSize: 40,
                            color: Color.fromRGBO(117, 93, 236, 1),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Decrement',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(117, 93, 236, 1),
                          ),
                          child: IconButton(
                            onPressed: _incrementCounter,
                            icon: Icon(Icons.add_rounded),
                            iconSize: 50,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Increment',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(230, 223, 249, 1),
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: IconButton(
                              onPressed: _resetCounter,
                              icon: Icon(Icons.refresh_rounded),
                              iconSize: 40,
                              color: Color.fromRGBO(117, 93, 236, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Reset', style: TextStyle(color: Colors.blueGrey)),
                      ],
                    ),
                  ],
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
