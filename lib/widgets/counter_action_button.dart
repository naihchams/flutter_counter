import 'dart:math';

import 'package:flutter/material.dart';

class CounterActionButton extends StatelessWidget {
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

  CounterActionButton({
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isCircle
            ? Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                ),
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(icon),
                  iconSize: iconSize,
                  color: iconColor,
                ),
              )
            : Container(
                height: buttonSize,
                width: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: borderRadius,
                  color: backgroundColor,
                ),
                child: isReset
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: IconButton(
                          onPressed: onTap,
                          icon: Icon(icon),
                          iconSize: iconSize,
                          color: iconColor,
                        ),
                      )
                    : IconButton(
                        onPressed: onTap,
                        icon: Icon(icon),
                        iconSize: iconSize,
                        color: iconColor,
                      ),
              ),
        SizedBox(height: 10),
        Text(label, style: TextStyle(color: textColor)),
      ],
    );
  }
}
