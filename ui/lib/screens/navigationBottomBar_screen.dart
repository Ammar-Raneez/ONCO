import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/chatbot_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';

class NavigationBottomBarScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "homeScreen";

  @override
  _NavigationBottomBarScreenState createState() => _NavigationBottomBarScreenState();
}

class _NavigationBottomBarScreenState extends State<NavigationBottomBarScreen> {
  int currentIndex = 0;

  List<Widget> listOfColors = [
    HomeScreen(),
    MainCancerTypesScreen(),
    ChatBotScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // under this body only the screen go into
      body: listOfColors[currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print("This is the value of the index: " + index.toString());
        },
        items: [
          Icon(Icons.home, size: 30,),
          Icon(Icons.widgets_outlined, size: 30,),
          Icon(Icons.chat, size: 30,),
        ],
      ),
    );
  }
}
