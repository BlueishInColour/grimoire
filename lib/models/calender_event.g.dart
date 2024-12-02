// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalenderEvent _$CalenderEventFromJson(Map<String, dynamic> json) =>
    CalenderEvent(
      id: json['id'] as String? ?? "",
      eventDate: DateTime.parse(json['eventDate'] as String),
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$CalenderEventToJson(CalenderEvent instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'eventDate': instance.eventDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'id': instance.id,
    };
