
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "feedback_model.g.dart";

@JsonSerializable()
class FeedbackModel  {
  FeedbackModel({
    this.feedbackId="",
    this.replyEmail="",
    this.text ="",

  });

  String replyEmail;
  String text;
  DateTime createdAt = DateTime.now();
  String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";
  String feedbackId;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}