import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/CONSTANT.dart';
import '../main_controller.dart';
import '../repository/chat_repository.dart';
import 'chat_screen.dart';
import '../models/content_model.dart';
import '../models/message.dart';

class ChatController extends MainController {
  final repo = ChatRepository();
  ContentModel content = ContentModel();
  final chatController = TextEditingController();

  List<List<String>> _listOfChatKey = [];
  List<List<String>> get listOfChatKey => _listOfChatKey;
  addListOfChatKey(List<String> v) {
    _listOfChatKey.add(v);
    notifyListeners();
  }

  bool checkChatKey(List<String> v) {
    return _listOfChatKey.contains(v);
  }
  //
  // addMoreMessage(context, String recieverEmail) async {
  //   isMediaUploading = true;
  //   Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //           pageBuilder: (context, _, __) => CreateContentScreen(
  //                 afterOneUpload: (v, content) {
  //                   debugPrint("after ine upload");
  //                 },
  //                 afterTotalUpload: (c) async {
  //                   Message message = Message(
  //                       text: c.text,
  //                       link: c.link,
  //                       location: c.location,
  //                       tags: c.tags,
  //                       mentions: c.mentions,
  //                       net_medias: c.net_medias,
  //                       receiverEmail: recieverEmail,
  //                       chatKey: chatKey(recieverEmail));
  //                   await repo.sendMessage(
  //                       id: message.id,
  //                       data: message.toJson(),
  //                       isCompleted: () {
  //                         // showSnackBar(context, "sent more message");
  //                       });
  //                 },
  //               )));
  //   isMediaUploading = false;
  // }

  sendMessage(BuildContext context, String recieverEmail) async {
    Message message = Message(
        text: chatController.text,
        chatKey: chatKey(MY_UID));
    await repo.sendMessage(
      message: message
    );
  }
}
