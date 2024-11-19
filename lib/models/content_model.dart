import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'content_model.g.dart';

@JsonSerializable()
class ContentModel{
  ContentModel({
    this.text ="",
    this.content_type = "general",
    this.net_medias = const [],
    this.mentions = const [],
    this.tags =const [],
    this.link ="",
    this.location = const {},
    this.measurement = const {},
  });
  String text;
  List<String> net_medias;//images and videos
  List<String> tags;
  List<String> mentions;
  String link;
  Map<String,String> location;
  Map<String,String> measurement;

  String id = Uuid().v1();
  String content_type; //general or model
  String created_by = FirebaseAuth.instance.currentUser?.email ?? "";
  DateTime created_at = DateTime.now();



  factory ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);
}