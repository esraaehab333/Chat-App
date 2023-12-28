import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomChatBuble extends StatelessWidget {
  const CustomChatBuble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: EnableBorderSideColor,
        ),
        child: const Text(
          "hello",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
