
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "news_model.g.dart";

@JsonSerializable()
class NewsModel  {
NewsModel({
this.title = "",
  this.id="",
  this.urlLink ="",
  this.imageUrl = ""
});

String id;

String title;
String imageUrl;
String urlLink;


DateTime createdAt = DateTime.now();
String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}