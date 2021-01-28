import 'package:flutter/material.dart';

class MainCancerTypesScreen extends StatefulWidget {
  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff01CDFA),
      child: Center(
        child: Text("This is the screen which displays the list of cancer for prognosis and disgnosis"),
      ),
    );
  }
}
