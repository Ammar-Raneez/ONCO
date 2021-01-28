import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff01CDFA),
        child: Center(
          child: Text("This is the HomeScreen",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
