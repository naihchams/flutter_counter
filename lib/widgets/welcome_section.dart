import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Welcome! 👋",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(height: 5),
        Text(
          'Simple counter to increase, decrease, and reset',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ],
    );
  }
}
