import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

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

  SettingsScreen(String userName, String email)
  {
    this.userName = userName;
    this.email = email;
  }

  @override
  _SettingsScreenState createState() => _SettingsScreenState(userName, email);

}

class _SettingsScreenState extends State<SettingsScreen> {

  String userName;
  String email;

  _SettingsScreenState(String userName, String email)
  {
    this.userName = userName;
    this.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      padding: EdgeInsets.only(left: 25),
                      width: 322.0,
                      height: 150,
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
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      fontSize: 16.0,
                                      color: Color(0xFFE1F6FD),
                                    ),
                                ),
                                 Text(
                                    email,
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
                ],
              ),
            ),
          ),
        )
    );
  }
}
