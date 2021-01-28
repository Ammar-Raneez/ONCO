import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          print("This is the value of the index: " + index.toString());
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            activeColor: Color(0xff01CDFA),
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.widgets_outlined),
            title: Text("Cancers"),
            activeColor: Color(0xff01CDFA),
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat),
            title: Text("Chatbot"),
            activeColor: Color(0xff01CDFA),
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
