import 'package:flutter/material.dart';
import 'package:ui/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {

  // static 'id' variable for the naming convention for the routes
  static String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 3000), (){

      print("Runnign after 3s ");
      // Go to Login Screen after 3seconds from displaying the logo
      Navigator.pushNamed(context, LoginScreen.id);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Image.asset('images/officialLogo.png'),
                  height: 50,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
