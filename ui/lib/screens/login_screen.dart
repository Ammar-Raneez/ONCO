import 'package:flutter/material.dart';
import 'package:ui/constants.dart';

class LoginScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(gradient: kBackgroundBlueGradient),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    height: 30,
                    child: Image.asset('images/officialLogo.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
