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
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 20,
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
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter
                ),
                borderRadius: BorderRadius.circular(22.0),
                color: Colors.white,
                  boxShadow: [
                  BoxShadow(
                  color: Color(0xFF7D7D7D).withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 16,
                  offset: Offset(4, 9), // changes position of shadow
                ),
                 ],
              ),
          ),
      ),
    );
  }
}
