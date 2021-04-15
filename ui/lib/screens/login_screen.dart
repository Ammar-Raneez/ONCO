import 'package:flutter/material.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/forgetPassword_screen.dart';
import 'package:ui/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/services/UserDetails.dart';

class LoginScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Variables used
  String email;
  String password;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final _firestore = FirebaseFirestore.instance;

  bool visiblePassword = false;
  bool showSpinner = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _emailAddressTextFieldController = TextEditingController();
  var _passwordTextFieldController = TextEditingController();

  // method to implement login functionality using username and password
  loginUserByEmailAndPassword(BuildContext context) async {
    if (email == null || email == "" || password == null || password == "") {
      // Alerts the user to fill all the fields required
      createAlertDialog(
          context, "Error", "Please fill all the given fields to proceed", 404);
    } else {
      // If all the fields are filled and ready to proceed
      setState(() {
        showSpinner = true;
      });

      try {
        // getting the logged in user details as a USER object or type
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // displaying alerts according to the progress
        if (user != null) {
          //clear chat bot messages on login/register
          _firestore.collection("chatbot-messages").doc(email)
              .collection("chatbot-messages").get()
              .then((value) => {
            for (var msg in value.docs) {
              msg.reference.delete()
            }
          });

          // Displaying the alert dialog
          setState(() {
            email = "";
            password = "";
          });


          // Getting a snapshot of the users (to get username of logged in user)
          QuerySnapshot querySnapshot = await _firestore.collection("users").get();
          querySnapshot.docs.forEach((document) {
            if (document.data()['userEmail'] == user.user.email) {
              // setting the user name and its email to the global user details variable
              UserDetails.setUserData(user.user.email, document.data()['username']);
            }
          });

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
  }

  // using GOOGLE Authentication to implement the login functionality
  googleAuthLogin(BuildContext context) async {
    try {
      await _googleSignIn.signIn().catchError((e) => (print(e.message)));
      print(_googleSignIn.currentUser);

      // Setting the user email to the global email variable to be used for
      // fire store use cases
      if (_googleSignIn.currentUser != null) {
        // Display the spinner because it will take time to fetch the data from the DB
        setState(() {
          showSpinner = true;
        });


        // setting the email for google sign in users
        GoogleUserSignInDetails.googleSignInUserEmail =
            _googleSignIn.currentUser.email;
        print("User is not null");

        // Now we sign out of this account once we get the email address
        _googleSignIn.signOut();
        print("Google Signing out...");

        bool emailDoesExist = false;

        // Checking with the database records to check if the google account has a ONCO account as well.
        QuerySnapshot querySnapshot = await _firestore.collection("users").get();
        querySnapshot.docs.forEach((document) {
          if (document.data()['userEmail'] ==
              GoogleUserSignInDetails.googleSignInUserEmail) {
            emailDoesExist = true;
            // adding user details for global access
            UserDetails.setUserData(GoogleUserSignInDetails.googleSignInUserEmail, document.data()['username']);
          }
        });

        // stop displaying the spinner
        setState(() {
          showSpinner = false;
        });

        // validated redirection
        if (emailDoesExist) {
          // IF it does exist then we proceed to "SUCCESS" navigation
          createAlertDialog(context, "Success", "Successfully logged in!", 200);

          //clear chat bot messages on login/register
          _firestore.collection("chatbot-messages").doc(GoogleUserSignInDetails.googleSignInUserEmail)
              .collection("chatbot-messages").get()
              .then((value) => {
            for (var msg in value.docs) {
              msg.reference.delete()
            }
          });

        } else {
          // ELSE we alert the user with appropriate message to register firstly.
          createAlertDialog(
              context,
              "Error",
              "There is no account register with the following email address,"
                  " therefore consider registering first to get access!",
              404);
        }
      } else {
        GoogleUserSignInDetails.googleSignInUserEmail = null;
        print("User is null");
      }
    } catch (e) {
      createAlertDialog(
          context, "Error", "Something went wrong!\nPlease re-try later", 404);
    }
    // stop displaying the spinner
    setState(() {
      showSpinner = false;
    });
  }

  // google auth logout
  googleAuthLogout() {
    _googleSignIn.signOut();
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
    double keyboardOpenVisibility = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomInset : false,
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
                        //Implement login functionality using google auth
                        googleAuthLogin(context);
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
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
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
      ),
    );
  }
}
