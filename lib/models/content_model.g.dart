// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
      text: json['text'] as String? ?? "",
      content_type: json['content_type'] as String? ?? "general",
      net_medias: (json['net_medias'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      link: json['link'] as String? ?? "",
      location: (json['location'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      measurement: (json['measurement'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    )
      ..id = json['id'] as String
      ..created_by = json['created_by'] as String
      ..created_at = DateTime.parse(json['created_at'] as String);

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'net_medias': instance.net_medias,
      'tags': instance.tags,
      'mentions': instance.mentions,
      'link': instance.link,
      'location': instance.location,
      'measurement': instance.measurement,
      'id': instance.id,
      'content_type': instance.content_type,
      'created_by': instance.created_by,
      'created_at': instance.created_at.toIso8601String(),
    };
