import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/current_screen.dart';

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
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
      ),
      title: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.notification_important,
                  color: Colors.redAccent,
                  size: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins-Regular',
                      fontSize: 19,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
      content: Text(
        message,
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 2.0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0, bottom: 5.0),
          child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            color: Color(0xff01CDFA),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {
              if (status == 200) {
                Navigator.pop(context); // pop the alert
                Navigator.pop(context); // pop on login / register screen
                Navigator.pushNamed(context, CurrentScreen.id);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
