import 'package:flutter/material.dart';
import 'package:ui/screens/login_screen.dart';

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
    controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 1.0);

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
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (_, __, ___) => LoginScreen(),
          ));
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
              Hero(
                tag: "logo",
                child: Container(
                  child: Image.asset('images/officialLogo.png'),
                  height: animation.value * 45,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
