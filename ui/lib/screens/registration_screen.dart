import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/services/UserDetails.dart';

// Firebase related variables
final _firestore = FirebaseFirestore.instance;

class RegistrationScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "registerScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Variables used for the registration page
  String username;
  String email;
  String password;
  String gender;
  int _radioValue = 0;

  bool visiblePassword = false;

  var _usernameController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();
  var _emailAddressController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

 @override
  void initState() {
    super.initState();
    gender = "male";
  }

  // handle radio button
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          gender = "male";
          break;
        case 1:
          gender = "female";
          break;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    // This variable is used to handle the screen widgets when the keyboard is opened
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
                            "Nice to see you here 👋",
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
                      "Register an Account",
                      textAlign: TextAlign.center,
                      style: kTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  TextField(
                    controller: _usernameController,
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Username",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _emailAddressController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Email Address",
                      prefixIcon: Icon(
                        Icons.alternate_email,
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
                      hintText: "Enter Password",
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
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Male',
                        style: kTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Female',
                        style: kTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
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
                    onPressed: () async {
                      if (username == null ||
                          email == null ||
                          password == null ||
                          username == "" ||
                          email == "" ||
                          password == "") {
                        createAlertDialog(context, "Error",
                            "Please fill all the given fields to proceed", 404);
                      } else {
                        // If details for all the fields are filled then proceed
                        // Display the spinner
                        setState(() {
                          showSpinner = true;
                        });

                        // register the user in firebase
                        try {
                          // created the user and returns a user once created
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                          // Adding the user details to the cloud fire store
                          _firestore.collection("users").doc(email).set({
                            "userEmail": email,
                            "username": username,
                            "gender": gender,
                            'timestamp': Timestamp.now(),
                          });

                          //clear chat bot messages on login/register
                          _firestore.collection("chatbot-messages").doc(email)
                              .collection("chatbot-messages").get()
                              .then((value) => {
                            for (var msg in value.docs) {
                              msg.reference.delete()
                            }
                          });

                          // displaying alerts according to the progress
                          if (newUser != null) {
                            // Adding the new registered user details to the global variable
                            UserDetails.setUserData(email, username);

                            // Displaying the alert dialog
                            createAlertDialog(context, "Success",
                                "Account Registered Successfully!", 200);
                          } else {
                            // Displaying the alert dialog
                            createAlertDialog(context, "Error",
                                "Something went wrong, try again later!", 404);
                          }

                          // stops displaying the spinner once the result comes back
                          setState(() {
                            showSpinner = false;
                          });

                          // clearing the content of the field once submitted
                          _emailAddressController.clear();
                          _usernameController.clear();
                          _passwordTextFieldController.clear();
                        } catch (e) {
                          createAlertDialog(context, "Error", e.message, 404);
                          // stops displaying the spinner once the result comes back
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      }
                    },
                    colour: Colors.lightBlueAccent,
                    title: 'REGISTER ACCOUNT',
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
