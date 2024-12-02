// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowModel _$FollowModelFromJson(Map<String, dynamic> json) => FollowModel(
      followedAt: json['followedAt'] as String,
    )
      ..followedBy = json['followedBy'] as String
      ..createdAt = DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$FollowModelToJson(FollowModel instance) =>
    <String, dynamic>{
      'followedBy': instance.followedBy,
      'followedAt': instance.followedAt,
      'createdAt': instance.createdAt.toIso8601String(),
    };
