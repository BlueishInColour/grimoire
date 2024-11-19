
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "scheduled_model.g.dart";

@JsonSerializable()
class ScheduledModel  {
  ScheduledModel({
    this.id="",
    this.releasedOn,
    this.scheduleId = "",
    this.type = ScheduleType.Book

  });

  DateTime createdAt = DateTime.now();
  DateTime? releasedOn;
  String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";
  String id;
  ScheduleType type;
  String scheduleId;

  factory ScheduledModel.fromJson(Map<String, dynamic> json) => _$ScheduledModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduledModelToJson(this);
}

enum ScheduleType{
  Book,
Story
}