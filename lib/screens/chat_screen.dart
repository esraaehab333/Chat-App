import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: TextColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return const CustomChatBuble();
            }),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: "Send Message",
                suffixIcon: Icon(
                  Icons.send,
                  color: EnableBorderSideColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: FoucseBorderSideColor),
                )),
          )
        ],
      ),
    );
  }
}
