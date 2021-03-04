import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/GoogleUserSignInDetails.dart';
import 'package:ui/constants.dart';

final _firestore = FirebaseFirestore.instance;

var loggedInUserEP;
var loggedInUserGoogle;

class ChatBotScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "chatBotScreen";

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  //used to clear the text field upon send
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        loggedInUserEP = user.email;
        print(loggedInUserEP);
      } else {
        // This will fire when user logs in using the Google Authentication way
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
        print(loggedInUserGoogle);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      messageText = value;
                    },
                    controller: messageTextController,
                    decoration: kTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection("chatbot-messages").add(
                        {'text': messageText, 'sender': loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle});
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
