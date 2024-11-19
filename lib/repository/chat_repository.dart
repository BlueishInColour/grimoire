  import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../models/message.dart';

String userUid = FirebaseAuth.instance.currentUser?.uid ?? "";


class ChatRepository{
CollectionReference<Map<String, dynamic>> get ref  => FirebaseFirestore.instance
  .collection("chat");
CollectionReference<Map<String, dynamic>> get friendRef =>FirebaseFirestore.instance
    .collection("friends")
    ;

  sendMessage({
    required Message message ,
    // required Function isCompleted
  })async {
    await ref
        .doc(message.id)
        .set(message.toJson()).whenComplete((){
          // isCompleted();

      setFriends(
              FirebaseAuth.instance.currentUser!.email ??"",
             message.receiverUid,
              message.id);
        });

  }
  Stream<Message> fetchOneMessage({required String id,required Function isCompleted})async*{
   DocumentSnapshot<Map<String, dynamic>> data =  await ref.doc(id).get();
   Message message = Message.fromJson(data.data()??{});
   yield message;

  }

void  readChat(Message message)async{
  if(message.receiverUid == FirebaseAuth.instance.currentUser?.uid&& message.sendetUid == FirebaseAuth.instance.currentUser?.uid)
  {
    await ref
        .doc(message.id)
        .update({"is_read":true});
  }
  else if(message.is_read==false&& FirebaseAuth.instance.currentUser?.uid!=message.sendetUid){
  await ref
  .doc(message.id)
  .update({"is_read":true});
  }

  }

Stream<int>  getUnreadChatCount(String chatKey)async*{
  QuerySnapshot<Map<String, dynamic>> res = await ref
      .where("chatKey", isEqualTo: chatKey)
      .where("is_read",isEqualTo: false)
      .where("receiverEmail",isEqualTo: FirebaseAuth.instance.currentUser?.email)
      .get();
  var res2 = res.size;
  yield res2;
}
Stream<int>  getTotalUnreadChatCount()async*{
  QuerySnapshot<Map<String, dynamic>> res = await ref
      .where("is_read",isEqualTo: false)
      .where("receiverEmail",isEqualTo: FirebaseAuth.instance.currentUser?.email)

      .get();
  var res2 = res.size;
  yield res2;
}




setFriends(String sender,String receiver, String last_message_id)async{
  await friendRef
      .doc(sender) //every emails get change in doc
      .collection("chat")
      .doc( receiver) //
      .set({
    "email" : receiver,
    "created_by": FirebaseAuth.instance.currentUser!.email,
    "created_at": DateTime.now(),
    "last_message_id": last_message_id
  });
  await friendRef
      .doc(receiver) //every emails get change in doc
      .collection("chat")
      .doc( sender) //
      .set({
    "email" : sender,
    "created_by": FirebaseAuth.instance.currentUser!.email,
    "created_at": DateTime.now(),
    "last_message_id": last_message_id
  });

}

CollectionReference<Map<String, dynamic>>  getFriends(){
return   friendRef
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("chat");

}


}
