import 'dart:math';
import 'package:flutter/material.dart';

class CounterActionButton extends StatefulWidget {
  final bool isResetDisabled;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double buttonSize;
  final double iconSize;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final bool isReset;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const CounterActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.buttonSize,
    required this.iconSize,
    this.borderRadius,
    required this.isCircle,
    required this.isReset,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.isResetDisabled,
  });

  @override
  State<CounterActionButton> createState() => _CounterActionButtonState();
}

class _CounterActionButtonState extends State<CounterActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.isResetDisabled;
    final button = Container(
      width: widget.buttonSize,
      height: widget.buttonSize,
      decoration: BoxDecoration(
        shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: widget.isCircle ? null : widget.borderRadius,
        color: isDisabled
            ? Color.fromRGBO(235, 232, 242, 1)
            : widget.backgroundColor,
      ),
      child: Center(
        child: widget.isReset
            ? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(
                  widget.icon,
                  size: widget.iconSize,
                  color: isDisabled
                      ? Color.fromRGBO(170, 164, 190, 1)
                      : widget.iconColor,
                ),
              )
            : Icon(widget.icon, size: widget.iconSize, color: widget.iconColor),
      ),
    );

    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() => _pressed = true);
          },
          onTapUp: (_) {
            setState(() => _pressed = false);
            widget.onTap();
          },
          onTapCancel: () {
            setState(() => _pressed = false);
          },
          child: AnimatedScale(
            scale: _pressed ? 0.92 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: button,
          ),
        ),
        const SizedBox(height: 10),
        Text(widget.label, style: TextStyle(color: widget.textColor)),
      ],
    );
  }
}
