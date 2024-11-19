// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      bookId: json['bookId'] as String? ?? "",
      reviewId: json['reviewId'] as String? ?? "",
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      ratingsCount: (json['ratingsCount'] as num?)?.toInt() ?? 0,
      reviewContent: json['reviewContent'] as String? ?? "",
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'ratingsCount': instance.ratingsCount,
      'reviewContent': instance.reviewContent,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'bookId': instance.bookId,
    };
