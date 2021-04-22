

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {

  final String cardTitle;
  final String cardImage;

  const ExerciseCard({@required this.cardTitle, @required this.cardImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 150,
          top: 20,
        ),
        child: Container(
          child: Container(
              height: 150.0,
              width: 275.0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                    child: Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.black,
                        fontFamily: 'Poppins-SemiBold',
                      ),
                    ),
                  ),
                ),
              ),
              decoration:BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/ExerciseImages/" + cardImage),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topCenter
                ),
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.white,
              )
          ),
          // color: Color(int.parse(cardColor)),
      ),
    );
  }
}
