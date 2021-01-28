import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/forgetPassword_screen.dart';
import 'package:ui/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // variables used for the login screen
  String email;
  String password;

  bool visiblePassword = false;

  var _emailAddressTextFieldController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();

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
                        "Welcome back!",
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
                  "Log in to your existing account",
                  textAlign: TextAlign.center,
                  style: kTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
              TextField(
                controller: _emailAddressTextFieldController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your email",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightBlueAccent,
                  ),

                ),
              ),
              TextField(
                controller: _passwordTextFieldController,
                obscureText: !visiblePassword,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightBlueAccent,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // GO TO THE FORGET PASSWORD SCREEN
                  Navigator.pushNamed(context, ForgetPassword.id);
                },
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.end,
                  style: kTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              RoundedButton(
                onPressed: () {
                  //Implement login functionality.
                  print("This is the email address: " + email);
                  print("This is the password: : " + password);

                  // clearing the text fields on submitted the details
                  _emailAddressTextFieldController.clear();
                  _passwordTextFieldController.clear();
                },
                colour: Colors.lightBlueAccent,
                title: 'LOG IN',
              ),
              Text(
                "Or connect using",
                textAlign: TextAlign.center,
                style: kTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              RoundedButton(
                onPressed: () {
                  //Implement login functionality.
                },
                colour: Colors.redAccent,
                title: 'Google',
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: kTextStyle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("U tapped the sign up button");
                        // GO TO THE SIGN IN SCREEN
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: Text("Sign Up",
                          style: kTextStyle.copyWith(
                            color: Color(0xff01CDFA),
                            fontSize: 13,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
