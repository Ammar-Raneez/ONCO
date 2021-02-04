import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  // static 'id' variable for the naming convention for the routes
  static String id = "chatBotScreen";

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child: Scaffold(

          body: Container(
              child: Center(
                child: Text("This is the chatbotScreen",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
        )
    );
  }
}
