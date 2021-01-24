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
          child: Padding(
            padding: EdgeInsets.all(35.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      height: 20,
                      child: Image.asset('images/officialLogo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 250,
                          child: Image.asset('images/clouds.png'),
                        ),
                      ),
                      Text("Welcome back!")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
