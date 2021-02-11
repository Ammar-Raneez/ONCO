import 'package:flutter/material.dart';

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
          child: Text("This is the HomeScreen",
              style: TextStyle(color: Colors.black)),
        ),
      ),
    ));
  }
}
