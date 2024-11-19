// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    FeedbackModel(
      feedbackId: json['feedbackId'] as String? ?? "",
      replyEmail: json['replyEmail'] as String? ?? "",
      text: json['text'] as String? ?? "",
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) =>
    <String, dynamic>{
      'replyEmail': instance.replyEmail,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'feedbackId': instance.feedbackId,
    };
