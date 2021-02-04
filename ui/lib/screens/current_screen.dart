import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ui/screens/chatbot_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';
import 'package:ui/components/custom_app_bar.dart';

class CurrentScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "navigationBottom";
  
  @override
  _CurrentScreenState createState() =>
      _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {

  // page controller is used to control the flow of the main pages (HOME, CANCER AND CHATBOT PAGE/SCREEN)
  int currentIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        
        appBar: CustomAppBar("settings"),

        // under this body only the screen go into
        body: PageView(
          
          controller: _pageController,

          // when you swipe through the screen (HOME, CANCER, CHATBOT)
          onPageChanged: (page) {
            
            setState(() {
              currentIndex = page;
            });      
          },
          // List of the Main Swiping Screens
          children: [HomeScreen(), MainCancerTypesScreen(), ChatBotScreen()],
          
        ),

        // Bottom bar navigation
        bottomNavigationBar: CurvedNavigationBar(
          
          backgroundColor: Color(0xff01CDFA),
          index: currentIndex,

          // Logic for the switching of MAIN SCREENS (HOME, CANCER, CHATBOT)
          onTap: (index) {
            
            setState(() {
              currentIndex = index;
              _pageController.jumpToPage(
                index,
              );
            });
          },
          items: [
            Icon(
              Icons.home, 
              size: 30
            ),
            Icon(
              Icons.widgets_outlined,
              size: 30,
            ),
            Icon(
              Icons.chat,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
