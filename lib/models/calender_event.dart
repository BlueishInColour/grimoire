
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "calender_event.g.dart";

@JsonSerializable()
class CalenderEvent  {
CalenderEvent({
  this.id="",

  required this.eventDate

});

DateTime createdAt = DateTime.now();
DateTime eventDate;
String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";
String id;

  factory CalenderEvent.fromJson(Map<String, dynamic> json) => _$CalenderEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalenderEventToJson(this);
}