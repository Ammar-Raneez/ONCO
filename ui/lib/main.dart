import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ui/screens/Meal%20Plan/all_meal_screen.dart';
import 'package:ui/screens/Meal%20Plan/meal_detail_screen.dart';
import 'package:ui/screens/Personal%20Manager/appointmentsManager/api/appointmentsProvider.dart';
import 'package:ui/screens/Personal%20Manager/medicationManager/api/medicationsProvider.dart';
import 'package:ui/screens/Personal%20Manager/reportManager/api/ReportProvider.dart';
import 'package:ui/screens/diagnosis/breastDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/lungDiagnosis_screen.dart';
import 'package:ui/screens/diagnosis/skinDiagnosis_screen.dart';
import 'package:ui/screens/forgetPassword_screen.dart';
import 'package:ui/screens/current_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:ui/screens/registration_screen.dart';
import 'package:ui/screens/welcome_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff01CDFA), // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReportProvider()),
        ChangeNotifierProvider(create: (context) => MedicationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

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
          AllMealScreen.id: (context) => AllMealScreen(),
          MealDetailScreen.id: (context) => MealDetailScreen()
        }
      ),
  );
}

// // Main method CALLED at which the APP STARTS INITIALLY
// void main() {
//   // String name = "";
//   runApp(MyApp());
// }
//
// // This is the Main MyApp class for the navigation lists
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // This is the first screen which will be displayed for the user when he opens the app
//       home: WelcomeScreen(),
//
//       // This is the initial route for the app
//       initialRoute: WelcomeScreen.id,
//
//       // Creating Named routes for all the pages (we used named routes when we deal with multiple routes 'more than 2')
//       routes: {
//         WelcomeScreen.id: (context) => WelcomeScreen(),
//         LoginScreen.id: (context) => LoginScreen(),
//         RegistrationScreen.id: (context) => RegistrationScreen(),
//         ForgetPassword.id: (context) => ForgetPassword(),
//         CurrentScreen.id: (context) => CurrentScreen(),
//         LungCancerDiagnosis.id: (context) => LungCancerDiagnosis(),
//         BreastCancerDiagnosis.id: (context) => BreastCancerDiagnosis(),
//         SkinCancerDiagnosis.id: (context) => SkinCancerDiagnosis(),
//       },
//     );
//   }
// }
