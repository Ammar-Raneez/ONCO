import 'package:flutter/material.dart';

//TODO - need to add functionality for passing colors into card, add font and finishing touches.

// This is the Cancer Card generator that accepts parameters to build a custom card for each cancer

class CancerCard extends StatelessWidget {
  //properties that are passed in
  final String cardTitle;
  final String cardColor;
  final String textColor;

  CancerCard({@required this.cardTitle, @required this.cardColor, @required this.textColor}); //constructor to init values

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        width: 400,
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 20.0),
          child: Text(
            cardTitle,
            style: TextStyle(
              fontSize: 23.0,
              color: Color(int.parse(textColor)),
              fontFamily: 'Poppins-SemiBold',
            ),
          ),
        ),
      ),
      color: Color(int.parse(cardColor)),
    );
    // width: 320.0,
    // height: 120.0,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xFFd3e5e8),
    // ),
  }
}
