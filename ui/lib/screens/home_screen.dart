import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/components/homepage_card.dart';
import 'package:ui/components/widgets.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'Personal Manager/personalManager_screen.dart';

//store current username
var username = "";

//To fetch username, and check current user
var loggedInUserEP;
var loggedInUserGoogle;

class HomeScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        loggedInUserEP = user.email;
      } else {
        // This will fire when user logs in using the Google Authentication way
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
      }

      //fetch username
      _firestore
          .collection("users")
          .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
          .get()
          .then((value) => {
        username = value.data()["username"],
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Center(
          child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:Container(
                    child: Text(
                      'Hello,\n${username.toString()}!',
                      style: TextStyle(
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 27.0,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(
                      'How can we help you?',
                        style: TextStyle(
                          color: Color(0xff59939F),
                        fontFamily: 'Poppins-SemiBold',
                        fontSize: 16.0,),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(

                    right: 10,
                    bottom: 5
                  ),
                  child: ScrollConfiguration(
                    behavior: ScrollEffectBehaviour(),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                            child:GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context)=> PersonalManager()
                                  ),
                                );
                              },
                                  child: HomeCard(cardTitle: 'Personal Manager', cardColor: '0xFFdb5682', textColor: '0xFFFFFFFF', ),
                            )
                        ),
                        Container(
                            child: HomeCard(cardTitle: 'Exercise Plan', cardColor: '0xFFa4d44a', textColor: '0xFFFFFFFF', )
                        ),
                        Container(
                            child: HomeCard(cardTitle: 'Meal Plan', cardColor: '0xFF4ad4b1', textColor: '0xFFFFFFFF', )
                        ),
                      ]
              ),
                  ),
                )
              ),
              SizedBox(
                height: 21,
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
