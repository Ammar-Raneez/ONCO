import 'package:flutter/material.dart';

class PersonalCard extends StatelessWidget {

  final String cardTitle;
  final String cardColor;
  final String textColor;

  PersonalCard({@required this.cardTitle, @required this.cardColor, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 3,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: 100.0,

                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15,
                      left:18,),

                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child:Text(
                      cardTitle,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(int.parse(textColor)),
                        fontFamily: 'Poppins-SemiBold',
                      ),
                    ),
                  ),
                ),
              ),
              color: Color(int.parse(cardColor)),
            ),
          ),
    );
  }
}
