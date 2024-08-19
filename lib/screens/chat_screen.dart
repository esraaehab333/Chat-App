// ignore_for_file: must_be_immutable

import 'package:chat_app/constants/color.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.email});
  final String email;
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CircleAvatar(
                backgroundImage: const AssetImage(
                    "assets/images/Cat astronaut-pana (1).png"),
                backgroundColor: MyPurple4,
              ),
            ),
            const Text("Chat"),
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: MyPurple4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Cat astronaut-cuate (4).png"),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit,ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? CustomChatBuble(message: messagesList[index])
                            : CustomChatBubleForFriend(
                                message: messagesList[index]);
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  controller.clear();
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                decoration: InputDecoration(
                  hintText: " Message",
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                    color: MyBrown2,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: MyPurple3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: MyPurple2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
