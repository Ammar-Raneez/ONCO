import 'package:flutter/material.dart';
import 'package:ui/screens/selectService_screen.dart';

// this is just a home page set to my pages to test my stuff ignore it and delete on final publish.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectServiceScreen(),
    );
  }
}
