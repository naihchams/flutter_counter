import 'package:counter_ui_practice/widgets/counter_action_button.dart';
import 'package:flutter/material.dart';

class CounterActions extends StatelessWidget {
  final Color primaryColor;
  final VoidCallback decrementFunction;
  final VoidCallback incrementFunction;
  final VoidCallback resetFunction;
  final bool isResetDisabled;

  const CounterActions({
    super.key,
    required this.primaryColor,
    required this.decrementFunction,
    required this.incrementFunction,
    required this.resetFunction,
    required this.isResetDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final normalButtonSize = width * 0.18;
    final centerButtonSize = width * 0.22;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CounterActionButton(
          isResetDisabled: false,
          icon: Icons.remove_rounded,
          label: 'Decrement',
          onTap: decrementFunction,
          buttonSize: normalButtonSize,
          iconSize: normalButtonSize * 0.5,
          isCircle: false,
          isReset: false,
          backgroundColor: primaryColor.withValues(alpha: 0.18),
          iconColor: primaryColor,
          textColor: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),

        CounterActionButton(
          isResetDisabled: false,
          icon: Icons.add_rounded,
          label: 'Increment',
          onTap: incrementFunction,
          buttonSize: centerButtonSize,
          iconSize: centerButtonSize * 0.5,
          isCircle: true,
          isReset: false,
          backgroundColor: primaryColor,
          iconColor: Colors.white,
          textColor: Colors.white,
        ),

        CounterActionButton(
          isResetDisabled: isResetDisabled,
          icon: Icons.refresh_rounded,
          label: 'Reset',
          onTap: resetFunction,
          buttonSize: normalButtonSize,
          iconSize: normalButtonSize * 0.5,
          isCircle: false,
          isReset: true,
          backgroundColor: primaryColor.withValues(alpha: 0.18),
          iconColor: primaryColor,
          textColor: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ],
    );
  }
}
