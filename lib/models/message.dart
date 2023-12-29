import 'package:chat_app/constants.dart';

class Message {
  final String message;
  Message(this.message);
  factory Message.fomJson(jsonData) {
    return Message(jsonData[KMessage]);
  }
}
