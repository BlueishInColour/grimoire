
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../constant/CONSTANT.dart';
import 'content_model.dart';

part "message.g.dart";

@JsonSerializable()
class Message  {

   Message(
      {
      this.text = "",
        // this.receiverUid = "",
        required this.chatKey,
        this.type = 0,
        this.question = ""
});

   String id = Uuid().v1();
   int type; // 0 for text, 1 links

   String text;
   String question;

   String senderEmail = FirebaseAuth.instance.currentUser?.email??"";
   String sendetUid = FirebaseAuth.instance.currentUser?.uid ?? "";
   String receiverUid = MY_UID;
  bool is_read  = false;
 String chatKey;
 DateTime created_at = DateTime.now();
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}