import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 55,
            width: 55,
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
          SizedBox(width: 20),
          Column(
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
              SizedBox(
                width: 250,
                child: Text(
                  'Use the button above to change the counter value',
                  style: TextStyle(color: Color.fromRGBO(87, 87, 91, 1)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
