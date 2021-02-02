import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

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

        backgroundColor: Color(0xff01CDFA),

        appBar: CustomAppBar("settings"),
        body: Container(

          child: Center(
            child: Text("This is the HomeScreen",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      )
    );
  }
}
