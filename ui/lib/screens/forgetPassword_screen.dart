import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:ui/components/alert_widget.dart';

class ForgetPassword extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "forgetPassword";

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // Variables used
  String email;
  var _emailAddressTextFieldController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  // Performing forget password functionality using firebase for resetting password
  forgetPasswordFunctionality(BuildContext context) async {
    if (email == null || email == "") {
      // Alert the user to enter the email
      createAlertDialog(
          context, "Error", "Please enter an email to proceed", 404);
    } else {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (!emailValid) {
        // Alerts invalid email
        createAlertDialog(context, "Error", "Invalid email format", 404);
      } else {
        // Since we have an email we can proceed
        // If all the fields are filled and ready to proceed
        setState(() {
          showSpinner = true;
        });

        try {
          _auth
              .sendPasswordResetEmail(email: email)
              .then(
                (value) => {
                  createAlertDialog(
                    context,
                    "Success",
                    "Please check your mail to reset password!",
                    404,
                  ),
                  // stops displaying the spinner once the result comes back
                  setState(() {
                    showSpinner = false;
                  })
                },
              )
              .catchError((e) {
            createAlertDialog(context, "Error", e.message, 404);
            // stops displaying the spinner once the result comes back
            setState(() {
              showSpinner = false;
            });
          });
        } catch (e) {
          createAlertDialog(context, "Error", e.message, 404);
          // stops displaying the spinner once the result comes back
          setState(() {
            showSpinner = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyboardOpenVisibility = MediaQuery.of(context).viewInsets.bottom;
    final node = FocusScope.of(context);

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
                      "Forgot your password?",
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  TextField(
                    autofillHints: [AutofillHints.email],
                    cursorColor: Colors.lightBlueAccent,
                    onEditingComplete: () => {
                      node.nextFocus(),
                      _emailAddressTextFieldController.text = email,
                    }, // Move focus to next
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
                  GestureDetector(
                    onTap: () {
                      // GO TO THE LOGIN SCREEN
                      Navigator.pop(context);
                    },
                    child: Text(
                      "<- Back to login",
                      textAlign: TextAlign.end,
                      style: kTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  RoundedButton(
                    onPressed: () {
                      //Implement forget password functionality.
                      forgetPasswordFunctionality(context);

                      // clearing the fields once all the data is collected
                      _emailAddressTextFieldController.clear();
                    },
                    colour: Colors.lightBlueAccent,
                    title: 'SUBMIT',
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
