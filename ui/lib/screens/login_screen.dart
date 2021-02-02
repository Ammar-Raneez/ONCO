import 'package:flutter/material.dart';
import 'package:ui/components/RoundedButton.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/forgetPassword_screen.dart';
import 'package:ui/screens/navigationBottomBar_screen.dart';
import 'package:ui/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variables
  String email;
  String password;
  bool visiblePassword = false;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  var _emailAddressTextFieldController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();

  // method to implement login functionality using username and password
  loginUserByEmailAndPassword(BuildContext context) async {
    setState(() {
      showSpinner = true;
    });

    try {
      // getting the logged in user details as a USER object or type
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // displaying alerts according to the progress
      if (user != null) {
        // Displaying the alert dialog
        createAlertDialog(context, "Success", "Successfully logged in!", 200);
      } else {
        // Displaying the alert dialog
        createAlertDialog(
            context, "Error", "Something went wrong, try again later!", 404);
      }

      // stops displaying the spinner once the result comes back
      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      createAlertDialog(context, "Error", e.message, 404);
      // stops displaying the spinner once the result comes back
      setState(() {
        showSpinner = false;
      });
    }
  }

  // creating an alert
  createAlertDialog(
      BuildContext context, String title, String message, int status) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          elevation: 24.0,
          actions: [
            MaterialButton(
              onPressed: () {
                if (status == 200) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, NavigationBottomBarScreen.id);
                } else {
                  Navigator.pop(context);
                }
              },
              elevation: 5.0,
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double keyboardOpenVisibility = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
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
                      loginUserByEmailAndPassword(context);

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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
        ),
      ),
    );
  }
}
