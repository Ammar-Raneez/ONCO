import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:ui/screens/chatbot_screen.dart';
import 'package:ui/screens/home_screen.dart';
import 'package:ui/screens/mainCancer_screen.dart';
import 'package:ui/components/custom_app_bar.dart';

class CurrentScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "navigationBottom";

  @override
  _CurrentScreenState createState() => _CurrentScreenState();
}

var username = "";

class _CurrentScreenState extends State<CurrentScreen> {
  // Page controller is used to control the flow of the main pages
  // (HOME, CANCER AND CHATBOT PAGE/SCREEN)
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;

  // using this User instance we can access the details of the logged user using
  // the normal email/pass auth method not the (Google Auth)
  User loggedInUser = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  var loggedInUserGoogle = "";

  @override
  void initState() {
    super.initState();
    // getting the current user details on loading of the screen
    getCurrentUser();
  }

  // Getting the current user details
  void getCurrentUser() async {

    try {
      // getting the current user (email/pass auth)
      final user = _auth.currentUser;
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        print("(Email-Password login) User is Present!");
        print(user.email);
      } else {
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
      }

      //fetch username
      var userDocument = await _firestore
          .collection("users")
          .doc(loggedInUser.email != null ? loggedInUser.email : loggedInUserGoogle)
          .get();

      setState(() {
        username = userDocument.data()['username'];
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
          // Google Sign Out and other login signOut
          print( "YOU ARE QUITTING THE APPLICATION BY CLICK THE BACK ICON FROM THE PHONE DEFAULT");

          // clearing the chatbot data from the database firestore
          _firestore.collection('chatbot-messages').get().then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) ds.reference.delete();
          });

          // (Email-Pass) user gets signed out
          _auth.signOut();

          // Google Auth User gets signed out
          GoogleUserSignInDetails.googleSignInUserEmail = null;

          print("Signing out......");

          // Future.delayed(const Duration(milliseconds: 200), () {
          //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // });

          return true;
        },
        child: Scaffold(
          appBar: CustomAppBar("settings", context),

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
            height:52,
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
                Icons.widgets_outlined,
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
      ),
    );
  }
}
