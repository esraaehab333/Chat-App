import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/strings.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KeyMessageCollection);
  List<Message> messageList = [];
  void sendMessage({required String message, required String email}) {
    try {
      messages
          .add({"message": message, "createdAt": DateTime.now(), "id": email});
    } on Exception catch (e) {}
  }

  void getMessages() {
    messages.orderBy("createdAt", descending: true).snapshots().listen(
      (event) {
        messageList.clear();
        for (var doc in event.docs) {
          messageList.add(Message.fomJson(doc));
        }
        emit(ChatSuccess(message: messageList));
      },
    );
  }
}
