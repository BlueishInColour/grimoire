
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "review_model.g.dart";

@JsonSerializable()
class ReviewModel  {
  ReviewModel({
    this.bookId="",
    this.reviewId="",
    this.updatedAt,
    this.ratingsCount=0,
    this.reviewContent="",


  });
  String  reviewId;

  int ratingsCount; //0 ---4
  String reviewContent;

  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;
  String createdBy=FirebaseAuth.instance.currentUser?.email ?? "";
  String bookId;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}