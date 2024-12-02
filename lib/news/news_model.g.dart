// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      title: json['title'] as String? ?? "",
      id: json['id'] as String? ?? "",
      urlLink: json['urlLink'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'urlLink': instance.urlLink,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
    };
