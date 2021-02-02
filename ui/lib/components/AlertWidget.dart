import 'package:flutter/material.dart';
import 'package:ui/screens/navigationBottomBar_screen.dart';

class AlertWidget extends StatelessWidget {

  // Variables
  final String title;
  final String message;
  final int status;

  // Constructor
  AlertWidget({this.title, this.message, this.status});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      elevation: 24.0,
      actions: [
        MaterialButton(
          onPressed: () {
            if (status == 200) {
              Navigator.pop(context);
              Navigator.pushNamed(context, NavigationBottomBarScreen.id);
            } else {
              Navigator.pop(context);
            }
          },
          elevation: 5.0,
          child: Text("OK"),
        ),
      ],
    );
  }
}