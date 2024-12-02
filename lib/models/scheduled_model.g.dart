// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledModel _$ScheduledModelFromJson(Map<String, dynamic> json) =>
    ScheduledModel(
      id: json['id'] as String? ?? "",
      releasedOn: json['releasedOn'] == null
          ? null
          : DateTime.parse(json['releasedOn'] as String),
      scheduleId: json['scheduleId'] as String? ?? "",
      type: $enumDecodeNullable(_$ScheduleTypeEnumMap, json['type']) ??
          ScheduleType.Book,
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$ScheduledModelToJson(ScheduledModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'releasedOn': instance.releasedOn?.toIso8601String(),
      'createdBy': instance.createdBy,
      'id': instance.id,
      'type': _$ScheduleTypeEnumMap[instance.type]!,
      'scheduleId': instance.scheduleId,
    };

const _$ScheduleTypeEnumMap = {
  ScheduleType.Book: 'Book',
  ScheduleType.Story: 'Story',
};
