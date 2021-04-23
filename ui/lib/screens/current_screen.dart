import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:ui/screens/chatbot_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';
import 'package:ui/components/custom_app_bar.dart';
import 'package:ui/services/UserDetails.dart';

// ignore: must_be_immutable
class CurrentScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "navigationBottom";
  String updatedUsername;
  String updatedEmail;
  String updatedGender;

  CurrentScreen();
  CurrentScreen.settingsNavigatorPush(
      this.updatedUsername, this.updatedEmail, this.updatedGender);

  @override
  _CurrentScreenState createState() {
    if (updatedUsername != null &&
        updatedEmail != null &&
        updatedGender != null)
      return _CurrentScreenState.settingsNavigatorPush(
          updatedUsername, updatedEmail, updatedGender);
    else
      return _CurrentScreenState();
  }
}

class _CurrentScreenState extends State<CurrentScreen> {
  // Page controller is used to control the flow of the main pages
  // (HOME, CANCER AND CHATBOT PAGE/SCREEN)
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  String username;
  String email;
  String gender;
  List<Widget> swipeScreen;

  _CurrentScreenState() {
    // getting the current user details on loading of the screen
    getCurrentUser();

    if (username == null) username = UserDetails.getUserData()["username"];

    if (gender == null) gender = UserDetails.getUserData()["gender"];

    if (email == null) email = UserDetails.getUserData()["email"];

    swipeScreen = [HomeScreen(), MainCancerTypesScreen(), ChatBotScreen()];
  }
  _CurrentScreenState.settingsNavigatorPush(
      this.username, this.email, this.gender) {
    swipeScreen = [
      HomeScreen.settingsNavigatorPush(username),
      MainCancerTypesScreen(),
      ChatBotScreen()
    ];
  }

  // using this User instance we can access the details of the logged user using
  // the normal email/pass auth method not the (Google Auth)
  User loggedInUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  var loggedInUserGoogle = "";

  // Getting the current user details
  void getCurrentUser() async {
    try {
      // getting the current user (email/pass auth)
      final user = _auth.currentUser;
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        print("(Email-Password login) User is Present!");
      } else {
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
      }

      //fetch username
      var userDocument = await _firestore
          .collection("users")
          .doc(loggedInUser.email != null
              ? loggedInUser.email
              : loggedInUserGoogle)
          .get();

      setState(() {
        username = userDocument["username"];
        email = userDocument["email"];
        gender = userDocument["gender"];
      });
    } catch (e) {
      print(e);
    }
  }

  // pageController for the navigation bar
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Stack(
          children: [
            Scaffold(
              appBar: CustomAppBar.settings(username, email, gender, context),
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
                children: swipeScreen,
              ),

              // Bottom bar navigation
              // bottomNavigationBar: CurvedNavigationBar(
              //   height:52,
              //   color: Color(0xff01CDFA),
              //   backgroundColor: Colors.transparent,
              //   index: currentIndex,
              //
              //   // Logic for the switching of MAIN SCREENS (HOME, CANCER, CHATBOT)
              //   onTap: (index) {
              //     setState(() {
              //       currentIndex = index;
              //       _pageController.jumpToPage(
              //         index,
              //       );
              //     });
              //   },
              //   items: [
              //     Icon(
              //       Icons.home,
              //       size: 27,
              //       color: Colors.white,
              //     ),
              //     Icon(
              //       Icons.widgets,
              //       size: 27,
              //       color: Colors.white,
              //     ),
              //     Icon(
              //       Icons.chat,
              //       size: 27,
              //       color: Colors.white,
              //     ),
              //   ],
              // ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedNavigationBar(
                height: 52,
                color: Color(0xff01CDFA),
                backgroundColor: Colors.transparent,
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
                    size: 27,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.widgets,
                    size: 27,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.chat,
                    size: 27,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
