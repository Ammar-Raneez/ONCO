import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';

class LoginScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool displayClouds = true;

  @override
  Widget build(BuildContext context) {
    double keyboardOpenVisibility = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: kBackgroundBlueGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              if (keyboardOpenVisibility == 0.0)
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
              if (keyboardOpenVisibility == 0.0)
                Text(
                  "Log in to your existing account",
                  textAlign: TextAlign.center,
                ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  // email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  // password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              Text(
                "Change Existing Password",
                textAlign: TextAlign.end,
              ),
              RoundedButton(
                  onPressed: () {
                    //Implement login functionality.
                  },
                  colour: Colors.lightBlueAccent,
                  title: 'LOG IN'),
              RoundedButton(
                  onPressed: () {
                    //Implement login functionality.
                  },
                  colour: Colors.redAccent,
                  title: 'Google'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  Text("Sign Up"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
