import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/rounded_button.dart';
import 'package:ui/constants.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/services/UserDetails.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home: SettingsScreen("abc", "abc@gmail.com"),
        );
  }
}

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "settingsScreen";
  String userName;
  String email;
  String gender;

  SettingsScreen(this.userName, this.email, this.gender);

  @override
  _SettingsScreenState createState() =>
      _SettingsScreenState(userName, email, gender);
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _userName;
  String _email;
  String _gender;
  String newGender;
  final _userNameController = TextEditingController();
  final _emailController = new TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _SettingsScreenState(this._userName, this._email, this._gender) {
    _userNameController.text = _userName;
    _emailController.text = _email;
  }

  void _changeUserName(String newDisplayName) async {
    var user = FirebaseAuth.instance.currentUser;
    var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
    var error = false;

    // Updating the Username in Firebase Authentication
    user
        .updateProfile(displayName: newDisplayName)
        .then((value) {})
        .catchError((e) {
      createAlertDialog(
          context, "Error", "There was an error updating profile", 404);
      error = true;
    });

    if (error != true) {
      var userDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.email != null ? user.email : loggedInUserGoogle)
          .get();

      var updatedUser = {
        "gender": "male",
        "timestamp": userDocument.data()['timestamp'],
        "userEmail": _email,
        "username": newDisplayName
      };

      // Updating the username Field of the Document of a Specific User in Collections user
      FirebaseFirestore.instance
          .collection("users")
          .doc(user.email != null ? user.email : loggedInUserGoogle)
          .set(updatedUser);
    }
  }

  void _changeEmail(String newEmail, String password) async {
    var user = FirebaseAuth.instance.currentUser;
    var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
    var error = false;

    // Updating the Username in Firebase Authentication
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: password)
        .then((userCredential) {
      userCredential.user.updateEmail(newEmail);
    }).catchError((e) {
      createAlertDialog(
          context, "Error", "There Password that you've Entered is Wrong", 404);
      error = true;
    });

    if (!error) {
      var userDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.email != null ? user.email : loggedInUserGoogle)
          .get();

      var updatedUser = {
        "gender": "male",
        "timestamp": userDocument.data()['timestamp'],
        "userEmail": newEmail,
        "username": _userName
      };

      final firestore = FirebaseFirestore.instance;

      // Updating the username Field of the Document of a Specific User in Collections user
      firestore
          .collection("users")
          .doc(user.email != null ? user.email : loggedInUserGoogle)
          .get()
          .then((doc) {
        if (doc.exists) {
          // saves the data to 'name'
          firestore
              .collection("users")
              .doc(newEmail)
              .set(updatedUser)
              .then((value) {
            // deletes the old document
            firestore.collection("users").doc(_email).delete();
            UserDetails.setUserData(newEmail, _userName, _gender);
          });
        }
      });
    }
  }

  void _changeGender(String newGender) async {
    var user = FirebaseAuth.instance.currentUser;
    var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;

    var userDocument = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email != null ? user.email : loggedInUserGoogle)
        .get();

    var updatedUser = {
      "gender": newGender,
      "timestamp": userDocument.data()['timestamp'],
      "userEmail": _email,
      "username": _userName
    };

    // Updating the gender Field of the Document of a Specific User in Collections user
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.email != null ? user.email : loggedInUserGoogle)
        .set(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar.arrow(context),
        body: ListView(children: [
          Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold',
                      fontSize: 27,
                      color: Color(0xFF637477),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Color(0xFFABD8E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            Icons.account_box,
                            color: Colors.white,
                            size: 64,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _userName,
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 16.0,
                                  color: Color(0xFF008B99),
                                ),
                              ),
                              Text(
                                _email,
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 14.0,
                                  color: Color(0xFF565D5E),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(email: _email);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Reset Password Email has been Sent !',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: "Poppins-SemiBold"),
                                      ),
                                      backgroundColor: Color(0xFFABD8E2),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Reset Password?",
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 30,
                          controller: _userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: TextSelectionThemeData().cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Color(0xff00b3d9),
                                fontSize: 15,
                                fontFamily: 'Poppins-SemiBold'),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00b3d9),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  ConfirmChangePrimitiveWrapper
                                      confirmChangePrimitiveWrapper =
                                      new ConfirmChangePrimitiveWrapper(
                                          confirmChange: false);

                                  await createConfirmDialog(
                                      context,
                                      "Confirmation",
                                      "Are you Sure you want to Change your Username ?\n\n(Click outside the Alert Box to Cancel)",
                                      confirmChangePrimitiveWrapper);

                                  if (confirmChangePrimitiveWrapper
                                      .getConfirmChange()) {
                                    _changeUserName(_userNameController.text);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CurrentScreen.settingsNavigatorPush(
                                                _userNameController.text,
                                                _email,
                                                _gender),
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Color(0xff00b3d9),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF637477),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLength: 30,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$"
                                        r"%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailController.text) ==
                                false) {
                              return 'Please enter a Valid Email';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: TextSelectionThemeData().cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color(0xff00b3d9),
                                fontSize: 15,
                                fontFamily: 'Poppins-SemiBold'),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff00b3d9)),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  TextPrimitiveWrapper textPrimitiveWrapper =
                                      new TextPrimitiveWrapper("");
                                  await createTextFieldDialog(
                                      context,
                                      "Confirmation",
                                      "Are you Sure you want to Change your Email ?\n\n(Click outside the Alert Box to Cancel)",
                                      textPrimitiveWrapper);

                                  // ignore: unrelated_type_equality_checks
                                  if (textPrimitiveWrapper != "") {
                                    _changeEmail(_emailController.text,
                                        textPrimitiveWrapper.text);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CurrentScreen.settingsNavigatorPush(
                                                _userName,
                                                _emailController.text,
                                                _gender),
                                      ),
                                    );
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Color(0xff00b3d9),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF637477),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                margin: EdgeInsets.only(top: 0, bottom: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Color(0xFFABD8E2),
                                ),
                                child: Column(children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: GroupButton(
                                      unselectedTextStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: "Poppins-SemiBold"),
                                      selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-SemiBold"),
                                      selectedColor: Color(0xff00b3d9),
                                      spacing: 20,
                                      onSelected: (index, isSelected) async {
                                        if (index == 0)
                                          newGender = "male";
                                        else
                                          newGender = "female";
                                      },
                                      buttons: ["Male", "Female"],
                                      selectedButtons: [
                                        "${_gender[0].toUpperCase()}${_gender.substring(1)}"
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: RawMaterialButton(
                                      onPressed: () async {
                                        ConfirmChangePrimitiveWrapper
                                            confirmChangePrimitiveWrapper =
                                            new ConfirmChangePrimitiveWrapper(
                                                confirmChange: false);

                                        await createConfirmDialog(
                                            context,
                                            "Confirmation",
                                            "Are you Sure you want to Change your Gender ?\n\n(Click outside the Alert Box to Cancel)",
                                            confirmChangePrimitiveWrapper);

                                        if (confirmChangePrimitiveWrapper
                                            .getConfirmChange()) {
                                          _changeGender(newGender);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => CurrentScreen
                                                  .settingsNavigatorPush(
                                                      _userName,
                                                      _email,
                                                      newGender),
                                            ),
                                          );
                                        }
                                      },
                                      fillColor: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Text(
                                              "Update Gender  ",
                                              style: TextStyle(
                                                fontFamily: 'Poppins-SemiBold',
                                                color: Colors.blueGrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Icon(
                                              Icons.update,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        ),
                                      ),
                                      shape: const StadiumBorder(),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                        RoundedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          colour: Colors.redAccent,
                          title: 'Log Out',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
