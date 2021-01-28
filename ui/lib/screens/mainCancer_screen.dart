import 'package:flutter/material.dart';

class MainCancerTypesScreen extends StatefulWidget {
  @override
  _MainCancerTypesScreenState createState() => _MainCancerTypesScreenState();
}

class _MainCancerTypesScreenState extends State<MainCancerTypesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text(
          "list of cancer for prognosis and disgnosis",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
