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
          bottom: 80,
          top: 20,
        ),
        child: Container(
          child: Container(
              height: 180.0,
              width: 250.0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 10.0),
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
                  image: AssetImage("images/" + cardImage),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topCenter
                ),
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.white,
              ),
          ),
      ),
    );
  }
}
