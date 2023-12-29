import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KeyMessageCollection);
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fomJson(snapshot.data!.docs[i]));
          }

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
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return CustomChatBuble(
                          message: messagesList[index],
                        );
                      }),
                ),
                TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    messages
                        .add({"message": value, "createdAt": DateTime.now()});
                    controller.clear();
                    _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  decoration: InputDecoration(
                    hintText: " Message",
                    suffixIcon: Icon(
                      Icons.send,
                      color: EnableBorderSideColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: FoucseBorderSideColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }
}
