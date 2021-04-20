import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/Meal%20Plan/screens/all_meal_screen.dart';

class MealHomeScreen extends StatelessWidget {
  static String id = "mealHomeScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'images/recipe.jpg',
      splashIconSize: 300,
      curve: Curves.easeInBack,
      duration: 2000,
      backgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 1500),
      nextScreen: AllMealScreen(),
    );
  }
}
