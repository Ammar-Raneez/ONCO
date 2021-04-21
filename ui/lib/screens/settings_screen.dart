import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:group_button/group_button.dart';
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

class SettingsScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "settingsScreen";
  String userName;
  String email;
  String gender;

  SettingsScreen(this.userName, this.email, this.gender);

  @override
  _SettingsScreenState createState() => _SettingsScreenState(userName, email, gender);

}

class _SettingsScreenState extends State<SettingsScreen> {

  String _userName;
  String _email;
  String _gender;
  String newGender;
  final _userNameController = TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  _SettingsScreenState(this._userName, this._email, this._gender)
  {
    print(_email + " EMAIL");
    _userNameController.text = _userName;
    _emailController.text = _email;
    print(_gender + " GENDER");
  }

  void _changeUserName(String newDisplayName) async {

    var user = FirebaseAuth.instance.currentUser;
    var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
    var error = false;

    // Updating the Username in Firebase Authentication
    user.updateProfile(displayName: newDisplayName).then((value){

    }).catchError((e){

      createAlertDialog(context, "Error", "There was an error updating profile", 404);
      error = true;
    });

    if (error != true) {

      print("im here");
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

          createAlertDialog(context, "Error", "There Password that you've Entered is Wrong", 404);
          error = true;
        });

    if (! error) {

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
              firestore.collection("users").doc(newEmail).set(updatedUser).then((value){
                // deletes the old document
              firestore.collection("users").doc(_email).delete();
              UserDetails.setUserData(newEmail, _userName, _gender);
              });
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar.arrow(context),
          body: ListView(
            children: [
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child:
                      Container(
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFC6E7EE), Color(0xFF637477)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
                        ),
                        padding: EdgeInsets.all(5),
                        width: 322.0,
                        height: 150,
                        child: Row(
                          children: <Widget>[
                            Expanded(

                              child: Icon(
                                Icons.account_box,
                                color: Colors.white,
                                size: 50,
                              ),
                              flex: 1,
                            ),
                            Expanded(

                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    _userName,
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 16.0,
                                      color: Color(0xFFE1F6FD),
                                    ),
                                  ),
                                  Text(
                                    _email,
                                    style:TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 14.0,
                                      color: Color(0xFF565D5E),
                                    ),
                                  ),
                                ],
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: Theme.of(context).cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontFamily: 'Poppins-SemiBold'
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {

                                ConfirmChangePrimitiveWrapper confirmChangePrimitiveWrapper = new ConfirmChangePrimitiveWrapper(confirmChange: false);

                                await createConfirmDialog(context,
                                    "Confirmation", "Are you Sure you want to Change your Username ?\n\n(Click outside the Alert Box to Cancel)",
                                    confirmChangePrimitiveWrapper);

                                if (confirmChangePrimitiveWrapper.getConfirmChange())
                                {
                                  _changeUserName(_userNameController.text);

                                  print("ADADS " + _userNameController.text);

                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (_) => CurrentScreen.settingsNavigatorPush(_userNameController.text, _email, _gender)));
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                        TextFormField(
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          obscureText: true,
                          cursorColor: Theme.of(context).cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontFamily: 'Poppins-SemiBold'
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => {

                              },
                              icon: Icon(Icons.edit),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: Theme.of(context).cursorColor,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontFamily: 'Poppins-SemiBold'
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {

                                TextPrimitiveWrapper textPrimitiveWrapper = new TextPrimitiveWrapper("");
                                await createTextFieldDialog(context,
                                    "Confirmation", "Are you Sure you want to Change your Email ?\n\n(Click outside the Alert Box to Cancel)",
                                    textPrimitiveWrapper);

                                // ignore: unrelated_type_equality_checks
                                if (textPrimitiveWrapper != "")
                                {
                                  _changeEmail(_emailController.text, textPrimitiveWrapper.text);

                                  print(_emailController.text + "    ASIOdjasiodasiodasioda");

                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (_) => CurrentScreen.settingsNavigatorPush(_userName, _emailController.text, _gender)));
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20),
                            // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                child: Container(
                                  child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      margin: EdgeInsets.only(top: 0, bottom: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Color(0xFFABD8E2),
                                      ),
                                      child: Column(
                                          children: <Widget>[
                                            RawMaterialButton(
                                              onPressed: () {  },
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

                                            Container(
                                              margin: EdgeInsets.only(top: 20),
                                              child:GroupButton(
                                                selectedTextStyle: TextStyle(color: Colors.white),
                                                selectedColor: Colors.blueAccent,
                                                spacing: 20,
                                                onSelected: (index, isSelected) {

                                                  if (index == 0)

                                                    newGender = "male";

                                                  else newGender = "female";
                                                },
                                                buttons: ["Male", "Female"],
                                                selectedButtons: ["${_gender[0].toUpperCase()}${_gender.substring(1)}"],
                                              )
                                            )
                                          ]
                                      )
                                  ),
                                )
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ]
          ),
        )
    );
  }
}
