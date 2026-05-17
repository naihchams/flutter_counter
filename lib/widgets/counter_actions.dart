import 'package:counter_ui_practice/widgets/counter_action_button.dart';
import 'package:flutter/material.dart';

class CounterActions extends StatelessWidget {
  final VoidCallback decrementFunction;
  final VoidCallback incrementFunction;
  final VoidCallback resetFunction;

  CounterActions({
    super.key,
    required this.decrementFunction,
    required this.incrementFunction,
    required this.resetFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CounterActionButton(
          icon: Icons.remove_rounded,
          label: 'Decrement',
          onTap: decrementFunction,
          buttonSize: 75,
          iconSize: 40,
          isCircle: false,
          isReset: false,
          backgroundColor: Color.fromRGBO(230, 223, 249, 1),
          iconColor: Color.fromRGBO(117, 93, 236, 1),
          textColor: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),

        SizedBox(width: 40),
        CounterActionButton(
          icon: Icons.add_rounded,
          label: 'Increment',
          onTap: incrementFunction,
          buttonSize: 90,
          iconSize: 50,
          isCircle: true,
          isReset: false,
          backgroundColor: Color.fromRGBO(117, 93, 236, 1),
          iconColor: Colors.white,
          textColor: Colors.blueGrey,
        ),

        SizedBox(width: 40),
        CounterActionButton(
          icon: Icons.refresh_rounded,
          label: 'Reset',
          onTap: resetFunction,
          buttonSize: 75,
          iconSize: 40,
          isCircle: false,
          isReset: true,
          backgroundColor: Color.fromRGBO(230, 223, 249, 1),
          iconColor: Color.fromRGBO(117, 93, 236, 1),
          textColor: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ],
    );
  }
}
