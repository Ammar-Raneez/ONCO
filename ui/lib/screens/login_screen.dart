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
      body: Container(
        decoration: BoxDecoration(
          gradient: kBackgroundBlueGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: "logo",
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 20,
                    child: Image.asset('images/officialLogo.png'),
                  ),
                ),
              ),
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      height: 150,
                      child: Image.asset('images/clouds.png'),
                    ),
                    Text("Welcome back!")
                  ],
                ),
              ),
              Text(
                "Log in to your existing account", textAlign: TextAlign.center,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  // email = value;
                },
                // decoration: kTextFieldDecoration.copyWith(hintText: "Enter your email"),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  // password = value;
                },
                // decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"),
              ),
              Text(
                "Change Existing Password", textAlign: TextAlign.end,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
