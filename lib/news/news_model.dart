
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "history_model.g.dart";

@JsonSerializable()
class HistoryModel  {
HistoryModel({
  this.bookId="",
  this.updatedAt

});

DateTime createdAt = DateTime.now();
DateTime? updatedAt;
String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";
String bookId;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}