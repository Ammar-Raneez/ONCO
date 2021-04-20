import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/settings_screen.dart';

class AlertWidget extends StatelessWidget {
  // Variables
  final String title;
  final String message;
  final int status;
  ConfirmChange confirmChange;
  String buttonMessage = "OK";
  Widget _content;

  // Constructor
  AlertWidget(this.title, this.message, this.status) {

    _content = Text(
      message,
      style: TextStyle(color: Colors.black54),
    );
  }


  AlertWidget.settings(this.title, this.message, this.status, this.confirmChange)
  {
    buttonMessage = "Update";
    _content = Text(
      message,
      style: TextStyle(color: Colors.black54),
    );
  }

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
                Navigator.pushNamed(context, CurrentScreen.id);
              }
              else if (confirmChange != null) {
                confirmChange.setConfirmChange(true);
                Navigator.pop(context);
              }
              else {
                Navigator.pop(context);
              }
            },

            child: _content,
          ),
        ),
      ],
    );
  }
}

createAlertDialog(BuildContext context, String title, String message, int status) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget(title, message, status);
    },
  );
}

createConfirmDialog(BuildContext context, String title, String message, ConfirmChange confirmChange) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget.settings(title, message, 0, confirmChange);
    },
  );
}

class ConfirmChange
{
  bool confirmChange;

  ConfirmChange({this.confirmChange});

  void setConfirmChange(bool confirmChange)
  {
    this.confirmChange = confirmChange;
  }

  bool getConfirmChange()
  {
    return confirmChange;
  }
}