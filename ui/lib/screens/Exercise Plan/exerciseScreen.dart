import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';


class ExerciseScreen extends StatefulWidget {
  static var id = "exercisePlanScreen";

  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.arrow(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                  // padding: const EdgeInsets.only(left: 10, bottom: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Text(
                        "Exercise Plan",
                        style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 32,
                          color: Color(0xFF373737),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 27, bottom: 15),
                child: Text(
                  "Here you can find exercises specifically tailored for you",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 12,
                    color: Color(0xFF959595),
                  ),
                ),
              ),
            ),
            // Container(
            //     child:
            // ),
          ],
        ),
        )
    ),);
  }
}
