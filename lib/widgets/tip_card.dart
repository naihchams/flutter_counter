import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  final Color primaryColor;

  const TipCard({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardWidth = width * 0.9;
    final iconBoxSize = cardWidth * 0.16;
    final spacing = cardWidth * 0.05;

    final theme = Theme.of(context);

    return Container(
      height: 100,
      width: cardWidth,
      decoration: BoxDecoration(
        color: theme.cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.12),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.all(cardWidth * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: iconBoxSize,
            width: iconBoxSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle,
              color: primaryColor.withValues(alpha: 0.16),
            ),
            child: Icon(Icons.lightbulb_outline, color: primaryColor),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tip",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Use the button above to change the counter value',
                  style: TextStyle(color: Color.fromRGBO(87, 87, 91, 1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
