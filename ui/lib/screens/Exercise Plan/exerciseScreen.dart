import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
  static var id = "exercisePlanScreen";


}

class _ExerciseScreenState extends State<ExerciseScreen> {

  final rand = new Random();
  static var exerciseNames = [
    "Bicycle Crunches",
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
    if(selectedNames.length == exerciseNames.length) {
      selectedNames = [];
    }
    String ex = exerciseNames[rand.nextInt(exerciseNames.length)];
    while (selectedNames.contains(ex)) {
      ex = exerciseNames[rand.nextInt(exerciseNames.length)];
    }
    selectedNames.add(ex);
    return ex;
  }

  @override
  Widget build(BuildContext context) {
    var name_1 = randomExercise();
    var name_2 = randomExercise();
    var name_3 = randomExercise();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar.arrow(context),
            Column(
              children : [

                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 8,
                  ),
                  child: Align(

                    alignment: Alignment.topLeft,
                    child: Text(
                      "Exercise Plan",
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 14,
                      right: 20
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Here you can find exercises specifically tailored for you",
                      style: TextStyle(
                          fontFamily: 'Poppins-SemiBold',
                          fontSize: 13.0,
                          color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                            onTap: (){
                            },
                            child: ExerciseCard(cardTitle: name_1, cardImage: name_1.replaceAll(' ', '').toLowerCase() + ".jpg"),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: ExerciseCard(cardTitle: name_2, cardImage: name_2.replaceAll(' ', '').toLowerCase() + ".jpg"),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: ExerciseCard(cardTitle: name_3, cardImage: name_3.replaceAll(' ', '').toLowerCase() + ".jpg"),
                        ),
                      ),
                    ]
                ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
