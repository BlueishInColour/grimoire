
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "genre_model.g.dart";

@JsonSerializable()
class GenreModel  {

  GenreModel({
    this.title="",
    this.subGenres = const[]
});
  String title;
  List<String> subGenres;


  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}