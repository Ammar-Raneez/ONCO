

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
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        child: Container(

          child: Container(
              height: 130.0,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 18,
                  left:21,),

                child: Align(
                  alignment: Alignment.bottomLeft,
                  child:Text(
                    cardTitle,
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                      fontFamily: 'Poppins-SemiBold',
                    ),
                  ),
                ),
              ),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: Color(0xFFFFAA9090),
              )
          ),
          // color: Color(int.parse(cardColor)),
        ),
      ),
    );
  }
}
