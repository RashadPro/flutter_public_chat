import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.myMessage});
  // object from class Message
  final Message myMessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Color(0xffFEA92E),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            myMessage.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.friendMessage});
  // object from class Message
  final Message friendMessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006EF1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            friendMessage.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
            ),
          ),
        ),
      ),
    );
  }
}
