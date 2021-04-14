import 'package:flutter/material.dart';

// This is the Home Page Card generator that accepts parameters to build a custom card for each item in the home page

class HomeCard extends StatelessWidget {

  final String cardTitle;
  final String cardColor;
  final String textColor;
  final String imageName;

  HomeCard({@required this.cardTitle, @required this.cardColor, @required this.textColor, @required this.imageName}); //constructor to init values

  @override
  Widget build(BuildContext buildContext) => Padding(
    padding: const EdgeInsets.fromLTRB(12,0,0,0),
    child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage("images/" + imageName),
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
          ),
          width: 290.0,
          height: 480.0,

          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20),

            child: Align(
              alignment: Alignment.bottomLeft,
              child:Text(
              cardTitle,
              style: TextStyle(
                fontSize: 22.0,
                color: Color(int.parse(textColor)),
                fontFamily: 'Poppins-SemiBold',
              ),
            ),
          ),
          ),
        ),
        elevation: 2,
        // color: Color(int.parse(cardColor)),
      ),
  );
}
