import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';

class ChangePassword extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "changePassword";

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8.0,
              ),
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
                height: 5.0,
              ),
              if (keyboardOpenVisibility == 0.0)
                Flexible(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 150,
                        child: Image.asset('images/clouds.png'),
                      ),
                      Text(
                        "Hi there 👋",
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                          color: Color(0xff5b5b5b),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              if (keyboardOpenVisibility == 0.0)
                Text(
                  "Change your password",
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  // track the user current password
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Current password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  // track the user new password
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter New password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  // track the user confirm password
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter Confirm password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // GO TO THE LOGIN SCREEN
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to login",
                  textAlign: TextAlign.end,
                  style: kTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              RoundedButton(
                onPressed: () {
                  //Implement Change password functionality.
                },
                colour: Colors.lightBlueAccent,
                title: 'CHANGE PASSWORD',
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
