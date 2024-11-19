// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      bookId: json['bookId'] as String? ?? "",
      storyId: json['storyId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      storyCoverImageUrl: json['storyCoverImageUrl'] as String? ?? "",
      content: json['content'] as String? ?? "",
      private: json['private'] as bool? ?? true,
    )
      ..chapterIndex = (json['chapterIndex'] as num).toInt()
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedBy = json['updatedBy'] == null
          ? null
          : DateTime.parse(json['updatedBy'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'storyId': instance.storyId,
      'title': instance.title,
      'storyCoverImageUrl': instance.storyCoverImageUrl,
      'content': instance.content,
      'private': instance.private,
      'chapterIndex': instance.chapterIndex,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedBy': instance.updatedBy?.toIso8601String(),
      'createdBy': instance.createdBy,
    };
