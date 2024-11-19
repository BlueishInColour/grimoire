
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "follow_model.g.dart";

@JsonSerializable()
class FollowModel  {
  FollowModel({
    required this.followedAt ,

  });

  String followedBy=FirebaseAuth.instance.currentUser?.email ?? "";
  String followedAt;

  DateTime createdAt = DateTime.now();

  factory FollowModel.fromJson(Map<String, dynamic> json) => _$FollowModelFromJson(json);

  Map<String, dynamic> toJson() => _$FollowModelToJson(this);
}