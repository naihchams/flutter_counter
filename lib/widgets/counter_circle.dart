import 'package:flutter/material.dart';
import 'dart:math' as math;

class CounterCircle extends StatelessWidget {
  final int count;
  final Color primaryColor;

  const CounterCircle({
    super.key,
    required this.count,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final outerCircleSize = width * 0.78;
    final innerCircleSize = outerCircleSize * 0.72;
    final counterFontSize = outerCircleSize * 0.24;

    // Dynamically calculate the exact thickness of the outer ring
    final rimThickness = (outerCircleSize - innerCircleSize) / 2;

    return Center(
      child: SizedBox(
        width: outerCircleSize,
        height: outerCircleSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Outer Circle Background
            Container(
              width: outerCircleSize,
              height: outerCircleSize,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(isDark ? 0.12 : 0.16),
                shape: BoxShape.circle,
              ),
            ),

            // 2. FIXED: Sleek, uniform track-following light sweep
            TweenAnimationBuilder<double>(
              key: ValueKey(count),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 2 * math.pi,
                  child: SizedBox(
                    width: outerCircleSize,
                    height: outerCircleSize,
                    child: Align(
                      alignment: Alignment
                          .topCenter, // Anchors the light perfectly to the top rim
                      child: Container(
                        width: outerCircleSize * (isDark ? 0.28 : 0.35),
                        height:
                            rimThickness, // Constrains it strictly to the ring width
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                                    primaryColor.withOpacity(0.0),
                                    primaryColor.withOpacity(0.12),
                                    primaryColor.withOpacity(0.0),
                                  ]
                                : [
                                    Colors.white.withOpacity(0.0),
                                    Colors.white.withOpacity(0.60),
                                    Colors.white.withOpacity(0.0),
                                  ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // 3. Inner Circle
            Container(
              width: innerCircleSize,
              height: innerCircleSize,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.12),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: count.toDouble()),
                          duration: const Duration(milliseconds: 250),
                          builder: (context, value, child) {
                            return Text(
                              value.round().toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: counterFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        const Text(
                          "Current Count",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),

                    // Inner linear sweep highlight
                    TweenAnimationBuilder<double>(
                      key: ValueKey(count),
                      tween: Tween<double>(begin: -1.5, end: 1.5),
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value * innerCircleSize, 0),
                          child: Transform.rotate(
                            angle: -0.6,
                            child: Container(
                              width: innerCircleSize * 0.35,
                              height: innerCircleSize * 1.4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor.withOpacity(0.0),
                                    primaryColor.withOpacity(
                                      isDark ? 0.18 : 0.45,
                                    ),
                                    primaryColor.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
