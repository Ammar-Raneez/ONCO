import 'package:flutter/material.dart';

// the common rounded button
class RoundedButton extends StatelessWidget {
  // Variable attributes related to the Rounded Button
  final Color colour;
  final String title;
  final Function onPressed;

  // Constructor
  RoundedButton({this.title, this.colour, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 70.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 100.0,
          height: 20.0,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "Poppins-SemiBold"),
          ),
        ),
      ),
    );
  }
}
