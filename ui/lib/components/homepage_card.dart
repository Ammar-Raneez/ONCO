import 'package:flutter/material.dart';

// This is the Home Page Card generator that accepts parameters to build a custom card for each item in the home page

class HomeCard extends StatelessWidget {
  final String cardTitle;
  final String cardColor;
  final String textColor;
  final String cardImage;

  HomeCard(
      {@required this.cardTitle,
      @required this.cardColor,
      @required this.textColor,
      @required this.cardImage}); //constructor to init values

  @override
  Widget build(BuildContext buildContext) => Padding(
        padding: const EdgeInsets.fromLTRB(22, 15, 0, 35),
        child: Container(
          decoration: BoxDecoration(
            color: Color(
              int.parse(cardColor),
            ),
            borderRadius: BorderRadius.circular(19),
            image: DecorationImage(
              image: AssetImage(cardImage),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF7D7D7D).withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 16,
                offset: Offset(4, 9), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            width: 290.0,
            height: 480.0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  cardTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(
                      int.parse(textColor),
                    ),
                    fontFamily: 'Poppins-SemiBold',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
