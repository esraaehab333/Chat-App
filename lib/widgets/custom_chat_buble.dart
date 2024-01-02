
import 'package:chat_app/constants/color.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class CustomChatBuble extends StatelessWidget {
 const CustomChatBuble({
    super.key,required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25)
          ),
          color: MyPurple3,
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: MyGray,
          ),
        ),
      ),
    );
  }
}

class CustomChatBubleForFriend extends StatelessWidget {
 const CustomChatBubleForFriend({
    super.key,required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)
          ),
          color: MyBrown1,
        ),
        child: Text(
          message.message,
          style:  TextStyle(
            color: MyGray,
          ),
        ),
      ),
    );
  }
}
