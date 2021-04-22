import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/components/exercise_card.dart';
import 'package:ui/screens/Exercise%20Plan/TimerPage.dart';

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

  static var quotes = [
  "Strength does not come from the physical capacity. It comes from an indomitable will. – Mahatma Gandhi",
   "Training gives us an outlet for suppressed energies created by stress and thus tones the spirit just as exercise conditions the body. – Arnold Schwarzenegger",
    "If you have a body, you are an athlete! – Bill Bowerman",
    "Someone busier than you is working our right now.” – Unknown",
    "You can either suffer the pain of discipline or the pain of regret. –Jim Rohn"
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

  String randomQuote() {
    return quotes[rand.nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    var name_1 = randomExercise();
    var name_2 = randomExercise();
    var name_3 = randomExercise();
    var name_4 = randomExercise();
    var name_5 = randomExercise();
    var name_6 = randomExercise();

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
                          fontSize: 15,
                          color: Color(0xFF959595),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(37), bottomLeft: Radius.circular(37)),
                      color: Color(0xFF91C77E),
                    ),
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
                          Container(
                            child: GestureDetector(
                              onTap: (){
                              },
                              child: ExerciseCard(cardTitle: name_4, cardImage: name_4.replaceAll(' ', '').toLowerCase() + ".jpg"),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: (){
                              },
                              child: ExerciseCard(cardTitle: name_5, cardImage: name_5.replaceAll(' ', '').toLowerCase() + ".jpg"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              child: GestureDetector(
                                onTap: (){
                                },
                                child: ExerciseCard(cardTitle: name_6, cardImage: name_6.replaceAll(' ', '').toLowerCase() + ".jpg"),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20, top:20.0),
              child: Container(
                child: Text(
                  randomQuote(), style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'Poppins-SemiBold'
                ),
                ),
              ),
            )
          ],
        ),
        
      ),
    );
  }
}
