import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:ui/services/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsScreen("abc", "abc@gmail.com"),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "settingsScreen";
  String userName;
  String email;

  SettingsScreen(String userName, String email) {
    this.userName = userName;
    this.email = email;
  }

  @override
  SettingsScreenState createState() => SettingsScreenState(userName, email);

}

class SettingsScreenState extends State<SettingsScreen> {

  String _userName;
  String _email;
  final _userNameController = TextEditingController();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  SettingsScreenState(String userName, String email)
  {
    this._userName = userName;
    this._email = email;
    _userNameController.text = userName;
    _emailController.text = email;
    
  }

  void _changeUserName(String newDisplayName) async {

    var user = FirebaseAuth.instance.currentUser;
    var loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;

    // Updating the Username in Firebase Authentication
    user.updateProfile(displayName: newDisplayName).then((value){

    }).catchError((e){

      createAlertDialog(context, "Error", "There was an error updating profile", 404);
      return;
    });

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar.arrow(context),
          body: Container(
            child: Center(
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

                                ConfirmChange confirmChange = new ConfirmChange(confirmChange: false);

                                await createConfirmDialog(context,
                                    "Confirmation", "Are you Sure you want to Change your Username ?\n\n(Click outside the Alert Box to Cancel)",
                                    confirmChange);

                                if (confirmChange.getConfirmChange())
                                {
                                  _changeUserName(_userNameController.text);

                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (_) => CurrentScreen.settingsNavigatorPush(_userNameController.text)));
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
                          style:TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16.0,
                            color: Color(0xFF565D5E),
                          ),
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: _email,
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
                            suffixIcon: Icon(
                              Icons.edit,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF637477)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
