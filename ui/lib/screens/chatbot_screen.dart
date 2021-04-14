import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ui/services/GoogleUserSignInDetails.dart';
import 'package:ui/components/alert_widget.dart';
import 'package:ui/components/chatbot_message_bubble.dart';
import 'package:ui/constants.dart';

final _firestore = FirebaseFirestore.instance;

//To fetch username, and check current user
var loggedInUserEP = "";
var loggedInUserGoogle = "";

//store current username
var username = "";

class ChatBotScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "chatBotScreen";

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  //used to clear the text field upon send
  final messageTextController = TextEditingController();
  //current user (has email and password)
  final user = FirebaseAuth.instance.currentUser;

  Dio dio = new Dio();

  String messageText;
  var responseText;

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    setState(() {
      showSpinner = true;
    });

    try {
      if (user != null) {
        // This will run when the user logs in using the normal username and password way
        loggedInUserEP = user.email;
      } else {
        // This will fire when user logs in using the Google Authentication way
        loggedInUserGoogle = GoogleUserSignInDetails.googleSignInUserEmail;
      }

      //fetch username
      var userDocument = await _firestore
          .collection("users")
          .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
          .get();

      setState(() {
        username = userDocument.data()['username'];
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      showSpinner = false;
    });
  }

  createAlertDialog(
      BuildContext context, String title, String message, int status) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertWidget(
          title: title,
          message: message,
          status: status,
        );
      },
    );
  }

  void handleSendMessage() async {
    //clear text field on send
    messageTextController.clear();
    //add timestamp to be used for message sorting, current user's message
    //create message collection unique for each user, so multiple users can use at the same time
    _firestore
        .collection("chatbot-messages")
        .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
        .collection("chatbot-messages")
        .add({
      'text': messageText,
      'sender': username,
      'timestamp': Timestamp.now(),
    });

    // use this flag to disable the text field, since it takes
    // a few seconds for the initial response
    setState(() {
      responseText = "empty";
    });

    //send data to chat bot api and get back response
    try {
      Response response = await dio.post(
          'https://chatbot-deployment.azurewebsites.net/api/chatbot-deployment',
          data: {'UserIn': messageText});
      setState(() {
        responseText = response.toString();
      });

      //add chat bot response to firestore
      _firestore
          .collection("chatbot-messages")
          .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
          .collection("chatbot-messages")
          .add({
        'text': responseText,
        'sender': 'CHANCO',
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      // Displaying alert to the user
      createAlertDialog(context, "Error", e.message, 404);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        // if user is being fetched display a loading spinner
        child: username == ""
            ? Align(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/clouds.png'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MessageStream(),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  messageText = value;
                                },
                                enabled: responseText == "empty" ? false : true,
                                controller: messageTextController,
                                decoration: kTextFieldDecoration.copyWith(
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: handleSendMessage,
                                        color: Colors.lightBlueAccent),
                                    hintText: 'Write a message'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create a stream builder
    //that rebuilds itself on each change of query snapshot
    //in other words, the code is rebuilt whenever there's a change in the
    //firestore database
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("chatbot-messages")
          .doc(loggedInUserEP != null ? loggedInUserEP : loggedInUserGoogle)
          .collection("chatbot-messages")
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        //while fetching display a spinner
        if (!snapshot.hasData) {
          return Container(
            height: 0,
            width: 0,
          );
          /* Align(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          );*/
        }

        //order it based on most recent text
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];

          final messageBubble = MessageBubble(
            messageSender: messageSender,
            messageText: messageText,
            isMe: username == messageSender,
            time: DateFormat.yMMMd()
                .add_jm()
                .format(message.data()['timestamp'].toDate())
                .toString(),
          );
          messageBubbles.add(messageBubble);
        }

        //initial prompt message
        messageBubbles.add(
          new MessageBubble(
            messageSender: 'CHANCO',
            messageText:
                'Hi ${username.toString().toUpperCase()}! How can I help you today?',
            isMe: false,
            time: "",
          ),
        );

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

//Replace IP address here with deployment address
