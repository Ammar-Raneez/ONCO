import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String cardTitle;

  const TreatmentCard({@required this.cardTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 10,
      child: Container(
<<<<<<< HEAD
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage("images/" + cardImage),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
=======
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
>>>>>>> parent of 3713b55 (added styles adjustments for main cancer screen page, select service screen page and treatment card)
        ),
        padding: EdgeInsets.only(top: 100, left: 25),
        width: 322.0,
        height: 150,
        child: Text(
          cardTitle,
          style: TextStyle(
            fontSize: 23.0,
            color: Color(0xFF63888F),
            fontFamily: 'Poppins-SemiBold',
          ),
        ),
      ),
    );
  }
}
