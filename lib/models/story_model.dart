
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "story_model.g.dart";

@JsonSerializable()
class StoryModel  {

  StoryModel({
    this.bookId ="",
    this.storyId = "",

    this.title = "",
    this.storyCoverImageUrl = "",
    this.content = "",

    this.private =true



  });
  String bookId;
  String storyId;

  String title;
  String storyCoverImageUrl;
  String content;

  bool private;
  int chapterIndex = 0;

  DateTime createdAt  = DateTime.now();
  DateTime? updatedBy =DateTime.now();

  String createdBy = FirebaseAuth.instance.currentUser?.email ??"";


  factory StoryModel.fromJson(Map<String, dynamic> json) => _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}