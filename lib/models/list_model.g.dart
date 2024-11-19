// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModel _$ListModelFromJson(Map<String, dynamic> json) => ListModel(
      listId: json['listId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      listItems: (json['listItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recommend: json['recommend'] as bool?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.Drafted,
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$ListModelToJson(ListModel instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'listId': instance.listId,
      'title': instance.title,
      'listItems': instance.listItems,
      'recommend': instance.recommend,
      'status': _$StatusEnumMap[instance.status]!,
    };

const _$StatusEnumMap = {
  Status.Review: 'Review',
  Status.Private: 'Private',
  Status.Drafted: 'Drafted',
  Status.Scheduled: 'Scheduled',
  Status.Publish: 'Publish',
  Status.Rejected: 'Rejected',
  Status.Completed: 'Completed',
};
