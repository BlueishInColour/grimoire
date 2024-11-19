import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'chat_controller.dart';

Widget messagerBottomBar(

    BuildContext context,
    {required Function(String) onSendPressed,
    bool isSending=false,
      required void Function()? onAddImagePressed,
      int? noOfPickedImages = 0,
      String hintMessage = ""}) {
 return TextField(decoration: InputDecoration(fillColor: Colors.white,filled: true),);
  // return MessageBar(
  //   messageBarColor: Colors.white12,
  //   sendButtonColor: Colors.purple,
  //   messageBarHintText: hintMessage,
  //
  //
  //   onSend: (message)=>isSending?null:onSendPressed(message),
  //   actions: [
  //    IconButton(
  //       onPressed:onAddImagePressed,
  //       icon: Icon(Icons.add,color: Colors.white60,),
  //     ),
  //
  //   ],
  // );
}
