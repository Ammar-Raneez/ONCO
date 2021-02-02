import 'package:flutter/material.dart';
import 'package:ui/components/custom_app_bar.dart';

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

          backgroundColor: Color(0xff01CDFA),

          appBar: CustomAppBar("settings"),
          body: Container(

            child: Container(
              color: Color(0xff01CDFA),
              child: Center(
                child: Text("This is the chatbotScreen",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        )
    );
  }
}
