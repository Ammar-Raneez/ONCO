import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff01CDFA),
      child: Center(
        child: Text("This is the chatbotScreen"),
      ),
    );
  }
}
