import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ui/GoogleUserSignInDetails.dart';
import 'package:ui/screens/chatbot_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/login_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';
import 'package:ui/components/custom_app_bar.dart';

User loggedInUser;
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class CurrentScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "navigationBottom";

  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  // page controller is used to control the flow of the main pages (HOME, CANCER AND CHATBOT PAGE/SCREEN)
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // getting the current user details
  void getCurrentUser()async {

    try{
      final user = _auth.currentUser;

      if(user != null){
        // This will run when the user logs in using the normal username and password way
        print("Normal User is Present!");
        print(user.email);
      }else{
        // This will fire when user logs in using the Google Authentication way
        print(GoogleUserSignInDetails.googleSignInUserEmail);

      }

    }catch(e){
      print(e);
    }
  }

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Google Sign Out and other login signOut
          print("YOUUUU ARE QUITTING THE APPLICATION..............");
          _auth.signOut();
          GoogleUserSignInDetails.googleSignInUserEmail = null;
          print("Signing out......");
          // Future.delayed(const Duration(milliseconds: 200), () {
          //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // });
          return true;
        },
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
              Icon(Icons.home, size: 30),
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
      ),
    );
  }
}
