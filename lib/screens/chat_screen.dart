import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.email});
  final String email;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KeyMessageCollection);
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt", descending: true).snapshots(),
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
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? CustomChatBuble(message: messagesList[index])
                            : CustomChatBubleForFriend(
                                message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        "message": value,
                        "createdAt": DateTime.now(),
                        "id": email
                      });
                      controller.clear();
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeIn,
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
