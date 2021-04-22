import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/reports_card.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/diagnosis_reports_screen.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/report_widgets/ReportListWidget.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/settings_screen.dart';

class AlertWidget extends StatelessWidget {
  // Variables
  final String title;
  final String _message;
  final int _status;
  var _content;
  TextEditingController textEditingController = new TextEditingController();
  ConfirmChangePrimitiveWrapper confirmChangePrimitiveWrapper;
  TextPrimitiveWrapper textPrimitiveWrapper;
  String buttonMessage = "OK";

  // Constructor
  AlertWidget(this.title, this._message, this._status) {
    _content = Text(
      _message,
      style: TextStyle(color: Colors.black54),
    );
  }

  AlertWidget.settings(this.title, this._message, this._status,
      this.confirmChangePrimitiveWrapper) {
    buttonMessage = "Update";
    _content = Text(
      _message,
      style: TextStyle(color: Colors.black54),
    );
  }

  AlertWidget.textField(
      this.title, this._message, this._status, this.textPrimitiveWrapper) {
    buttonMessage = "Verify";
    _content = TextFormField(
      controller: textEditingController,
      style: TextStyle(
        fontFamily: 'Poppins-SemiBold',
        fontSize: 16.0,
        color: Color(0xFF565D5E),
      ),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.red, fontSize: 15, fontFamily: 'Poppins-SemiBold'),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF637477)),
        ),
      ),
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
      content: _content,
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
              if (_status == 404) {
                Navigator.pop(context); // pop the alert
              }

              if (_status == 201) {
                // Remove the alert widget and direct to report list
                Navigator.pop(context); // pop the alert
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiagnosisReports()),
                );
              }

              if (_status == 200) {
                Navigator.pop(context); // pop the alert
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CurrentScreen()));
              } else if (confirmChangePrimitiveWrapper != null) {
                confirmChangePrimitiveWrapper.setConfirmChange(true);
                Navigator.pop(context);
              } else if (textPrimitiveWrapper != null) {
                textPrimitiveWrapper._text = textEditingController.text;
                Navigator.pop(context);
              }
              // else {
              //   Navigator.pop(context);
              // }
            },
            child: Text(
              buttonMessage,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}

createAlertDialog(
    BuildContext context, String title, String message, int status) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget(title, message, status);
    },
  );
}

createConfirmDialog(BuildContext context, String title, String message,
    ConfirmChangePrimitiveWrapper confirmChange) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget.settings(title, message, 0, confirmChange);
    },
  );
}

createTextFieldDialog(BuildContext context, String title, String message,
    TextPrimitiveWrapper textPrimitiveWrapper) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget.textField(title, message, 0, textPrimitiveWrapper);
    },
  );
}

class ConfirmChangePrimitiveWrapper {
  bool confirmChange;

  ConfirmChangePrimitiveWrapper({this.confirmChange});

  void setConfirmChange(bool confirmChange) {
    this.confirmChange = confirmChange;
  }

  bool getConfirmChange() {
    return confirmChange;
  }
}

class TextPrimitiveWrapper {
  String _text;

  TextPrimitiveWrapper(this._text);

  String get text => _text;

  set text(String value) {
    _text = value;
  }
}
