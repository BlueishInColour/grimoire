// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String? ?? "",
      chatKey: json['chatKey'] as String,
      type: (json['type'] as num?)?.toInt() ?? 0,
      question: json['question'] as String? ?? "",
    )
      ..id = json['id'] as String
      ..senderEmail = json['senderEmail'] as String
      ..sendetUid = json['sendetUid'] as String
      ..receiverUid = json['receiverUid'] as String
      ..is_read = json['is_read'] as bool
      ..created_at = DateTime.parse(json['created_at'] as String);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'text': instance.text,
      'question': instance.question,
      'senderEmail': instance.senderEmail,
      'sendetUid': instance.sendetUid,
      'receiverUid': instance.receiverUid,
      'is_read': instance.is_read,
      'chatKey': instance.chatKey,
      'created_at': instance.created_at.toIso8601String(),
    };
