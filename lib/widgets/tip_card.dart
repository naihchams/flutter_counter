import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardWidth = width * 0.9;
    final iconBoxSize = cardWidth * 0.16;
    final spacing = cardWidth * 0.05;

    return Container(
      height: 100,
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2, // How much the shadow expands
            blurRadius: 20, // Softness of the shadow
            offset: Offset(0, 0),
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
              color: Color.fromRGBO(230, 223, 249, 1),
            ),
            child: Icon(
              Icons.lightbulb_outline,
              color: Color.fromRGBO(117, 93, 236, 1),
            ),
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
                    color: Color.fromRGBO(117, 93, 236, 1),
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
