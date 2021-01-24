import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  // static 'id' variable for the naming convention for the routes
  static String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Image.asset('images/officialLogo.png'),
                  height: 50,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
