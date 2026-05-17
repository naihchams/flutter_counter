import 'package:flutter/material.dart';

class CounterCircle extends StatelessWidget {
  final int count;

  const CounterCircle({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final outerCircleSize = width * 0.78;
    final innerCircleSize = outerCircleSize * 0.72;
    final counterFontSize = outerCircleSize * 0.24;

    return Center(
      child: Container(
        width: outerCircleSize,
        height: outerCircleSize,
        decoration: BoxDecoration(
          color: Color.fromRGBO(242, 239, 255, 1),

          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: innerCircleSize,
            height: innerCircleSize,
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 246, 253, 1),

              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Shadow color
                  spreadRadius: 2, // How much the shadow expands
                  blurRadius: 20, // Softness of the shadow
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: Color.fromRGBO(117, 93, 236, 1),
                      fontSize: counterFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Current Count",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
