import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String cardTitle;
  final String cardImage;

  const TreatmentCard({@required this.cardTitle, @required this.cardImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage("images/" + cardImage),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        padding: EdgeInsets.only(top: 100, left: 25),
        width: 322.0,
        height: 180,
        child: Text(
          cardTitle,
          style: TextStyle(
            fontSize: 23.0,
            color: Color(0xFFFFFFFF),
            fontFamily: 'Poppins-SemiBold',
          ),
        ),
      ),
    );
  }
}
