import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

class ExercisePlanScreen extends StatelessWidget {
  static var id = "exercisePlanScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Container(
       child: Scaffold(
         resizeToAvoidBottomInset: false,
         appBar: CustomAppBar.arrow(context),
         body: Text(
           "Hello"
         ),
       ),
    ),
    );
  }
}