
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "list_model.g.dart";

@JsonSerializable()
class ListModel  {
  ListModel({
    this.listId="",
    this.title = "",
    this.listItems = const [],
    this.recommend,
    this.status = Status.Drafted

  });

  DateTime createdAt = DateTime.now();
  String createdBy = FirebaseAuth.instance.currentUser?.email??"";
  String listId;
  String title;
  List<String> listItems ;
  bool? recommend;

  Status status;

  factory ListModel.fromJson(Map<String, dynamic> json) => _$ListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}