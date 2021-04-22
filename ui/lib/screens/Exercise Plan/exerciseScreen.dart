import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/exercise_card.dart';
import 'package:ui/components/widgets.dart';

class ExerciseScreen extends StatefulWidget {
  static var id = "exercisePlanScreen";

  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final rand = new Random();
  static var exerciseNames = [
    "Bicycle Crunch",
    "Calf Raises",
    "High Knees",
    "Jump Squats",
    "Jumping Jacks",
    "Planks",
    "Push Ups",
    "Sit Ups",
    "Squats",
    "Thigh Lunges"
  ];
  var selectedNames = [];

  String randomExercise() {
    var ex = exerciseNames[rand.nextInt(exerciseNames.length)];
    while (selectedNames.contains(ex)) {
      ex = exerciseNames[rand.nextInt(exerciseNames.length)];
    }
    selectedNames.add(ex);
    return ex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.arrow(context),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                   padding: const EdgeInsets.only(left: 10, bottom: 15),
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
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 5),
                    child: ScrollConfiguration(
                      behavior: ScrollEffectBehaviour(),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  var name = randomExercise();
                                  print(name);
                                  ExcerciseCard(
                                      cardTitle: name,
                                      cardImage:
                                      name.replaceAll(' ', '').toLowerCase() +
                                          ".jpg");
                                },

                                // child: ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  var name = randomExercise();
                                  ExcerciseCard(
                                      cardTitle: name,
                                      cardImage:
                                      name.replaceAll(' ', '').toLowerCase() +
                                          ".jpg");
                                },

                                // child: ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
