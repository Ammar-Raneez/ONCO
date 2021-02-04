import 'package:flutter/material.dart';
import 'package:ui/screens/mainCancer_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins-Regular',
        ),

      debugShowCheckedModeBanner: false,
      home: MainCancerTypesScreen(),
    );
  }
}
