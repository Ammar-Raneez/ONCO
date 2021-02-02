import 'package:flutter/material.dart';

//TODO - need to add functionality for passing colors into card, add font and finishing touches.

// This is the Cancer Card generator that accepts parameters to build a custom card for each cancer

class CancerCard extends StatelessWidget {
  //properties that are passed in
  final String cardTitle;

  CancerCard({@required this.cardTitle}); //constructor to init values

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        width: 320.0,
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0),
          child: Text(
            cardTitle, 
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF345860),
            ),
          ),
        ),
      ),
      color: Color(0xFFd3e5e8),
    );
    // width: 320.0,
    // height: 120.0,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xFFd3e5e8),
    // ),
  }
}
