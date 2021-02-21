import 'package:flutter/material.dart';
import 'package:ui/components/cancer_card.dart';
import 'package:ui/components/homepage_card.dart';

class HomeScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:Container(
                    child: Text(
                      'Hello, User Name!',
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 29.0,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'What do you need?',
                        style: TextStyle(
                          color: Color(0xff59939F),
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 16.0,),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                        child: HomeCard(cardTitle: 'Personal Manager', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', )),
                    Container(
                        child: HomeCard(cardTitle: 'Exercise Plan', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', )),
                    Container(
                        child: HomeCard(cardTitle: 'Meal Plan', cardColor: '0xFF7EB9C7', textColor: '0xFFFFFFFF', ))
                  ]
              )
              ),
              SizedBox(
                height: 21,
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
