import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/home_screen.dart';

class MealHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:AnimatedSplashScreen(
          splash: 'images/recipe.jpg',
          splashIconSize: 300,
          curve: Curves.easeInBack,
          duration: 2000,
          backgroundColor: Colors.white,
          animationDuration: Duration(milliseconds: 1500),
          nextScreen: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}











