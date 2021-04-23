import 'package:flutter/material.dart';

class PersonalCard extends StatelessWidget {
  final String cardTitle;
  final String cardColor1;
  final String cardColor2;
  final String textColor;

  PersonalCard(
      {@required this.cardTitle,
      @required this.cardColor1,
      @required this.cardColor2,
      @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        child: Container(
          child: Container(
              height: 130.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 18,
                  left: 21,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    cardTitle,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Color(int.parse(textColor)),
                      fontFamily: 'Poppins-SemiBold',
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                gradient: LinearGradient(
                  colors: [
                    Color(int.parse(cardColor2)),
                    Color(int.parse(cardColor1)),
                  ],
                  begin: Alignment(1.2, 1),
                  end: Alignment(0.8, -2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(int.parse(cardColor2)).withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(7, 9), // changes position of shadow
                  ),
                ],
              )),
          // color: Color(int.parse(cardColor)),
        ),
      ),
    );
  }
}
