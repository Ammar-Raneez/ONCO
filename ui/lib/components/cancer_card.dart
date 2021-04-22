import 'package:flutter/material.dart';

//TODO - need to add functionality for passing colors into card, add font and finishing touches.

// This is the Cancer Card generator that accepts parameters to build a custom card for each cancer

class CancerCard extends StatelessWidget {
  //properties that are passed in
  final String cardTitle;
  final String cardColor;
  final String cardColor2;
  final String textColor;

  CancerCard({@required this.cardTitle, @required this.cardColor,@required this.cardColor2, @required this.textColor}); //constructor to init values

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Color(int.parse(cardColor)),
            Color(int.parse(cardColor2)),
          ],
          begin: Alignment(1.2,1),
          end: Alignment(0.8,-2),
        ),
        boxShadow: [
          BoxShadow(
            color:  Color(int.parse(cardColor)).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 15,
            offset: Offset(7, 9), // changes position of shadow
          ),
        ],
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
    );
  }
}