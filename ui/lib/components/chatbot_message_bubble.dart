import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/constants.dart';

// bot message bubbles
class MessageBubble extends StatelessWidget {
  final String messageSender;
  final String messageText;
  final bool isMe;
  final String time;

  MessageBubble({this.messageSender, this.messageText, this.isMe, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            messageSender,
            style: kTextStyle.copyWith(fontSize: 12.0),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$messageText',
                style: kTextStyle.copyWith(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          Text(
            '$time',
            style: kTextStyle.copyWith(
              color: Colors.grey,
              fontSize: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}
