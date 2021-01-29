import 'package:flutter/material.dart';

class MainCancerTypesScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "mainCancerTypesScreen";

  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff01CDFA),
        child: Center(
          child: Text(
            "list of cancer for prognosis and disgnosis",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
