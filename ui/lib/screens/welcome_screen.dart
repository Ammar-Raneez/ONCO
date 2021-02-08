import 'package:flutter/material.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class WelcomeScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  // We are creating Animation Controller in order to create our own custom Animations
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    // initialize the firebase app
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

    controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this, upperBound: 1.0);

    // This below animation can be used when u need to add some speed for your animation
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // starting the animation
    controller.forward();

    controller.addListener(() {
      // we are using the setState because the value of "controller.value" changes always as a part of the animation
      setState(() {});
    });

    // Go to Login Screen after 3seconds from displaying the logo
    goToLoginScreen();
  }

  void goToLoginScreen(){

    // Go to Login Screen after a given time duration
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 5),
            pageBuilder: (_, __, ___) => LoginScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff01CDFA),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      goToLoginScreen();
                    });
                  },
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/officialLogo.png'),
                      height: animation.value * 45,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
