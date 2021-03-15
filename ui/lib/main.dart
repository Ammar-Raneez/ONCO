import 'package:flutter/material.dart';
import 'package:ui/screens/diagnosis/breastDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';
import 'package:ui/screens/forgetPassword_screen.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:ui/screens/registration_screen.dart';
import 'package:ui/screens/welcome_screen.dart';

// Main method CALLED at which the APP STARTS INITIALLY
void main() {
  // String name = "";
  runApp(MyApp());
}

// This is the Main MyApp class for the navigation lists
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // This is the first screen which will be displayed for the user when he opens the app
      home: WelcomeScreen(),

      // This is the initial route for the app
      initialRoute: WelcomeScreen.id,

      // Creating Named routes for all the pages (we used named routes when we deal with multiple routes 'more than 2')
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ForgetPassword.id: (context) => ForgetPassword(),
        CurrentScreen.id: (context) => CurrentScreen(),
        LungCancerDiagnosis.id: (context) => LungCancerDiagnosis(),
        BreastCancerDiagnosis.id: (context) => BreastCancerDiagnosis(),
        SkinCancerDiagnosis.id: (context) => SkinCancerDiagnosis(),
      },
    );
  }
}
