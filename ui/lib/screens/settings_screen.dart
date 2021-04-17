import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

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

            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}


// creating an alert
createAlertDialog(
    BuildContext context, String title, String message, int status) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertWidget(
        title: title,
        message: message,
        status: status,
      );
    },
  );
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsScreen("abc", "abc@gmail.com"),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "settingsScreen";
  String userName;
  String email;

  SettingsScreen(String userName, String email) {
    this.userName = userName;
    this.email = email;
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState(userName, email);

}

class _SettingsScreenState extends State<SettingsScreen> {

  String userName;
  String email;

  _SettingsScreenState(String userName, String email)
  {
    this.userName = userName;
    this.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar.arrow(context),
          body: Container(
            child: Center(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 20, bottom: 20),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27,
                        color: Color(0xFF637477),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child:
                    Container(
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
                      ),
                      padding: EdgeInsets.only(left: 25),
                      width: 322.0,
                      height: 150,
                      child: Row(
                        children: <Widget>[
                          Expanded(

                            child: Icon(
                              Icons.account_box,
                              color: Colors.white,
                              size: 64,
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 20.0,
                                      color: Color(0xFFE1F6FD),
                                    ),
                                ),
                                 Text(
                                    email,
                                    style:TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 16.0,
                                      color: Color(0xFF565D5E),
                                    ),
                                  ),
                              ],
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      )
                    ),
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: userName,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.edit),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                        TextFormField(
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          obscureText: true,
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: 'Password',
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => {
                                createAlertDialog(context, "GOOD", "WOW", 2),
                              },
                              icon: Icon(Icons.edit),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                        TextFormField(
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: email,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
