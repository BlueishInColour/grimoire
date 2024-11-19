// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      country: json['country'] as String? ?? "",
      state: json['state'] as String? ?? "",
      city: json['city'] as String? ?? "",
      full_name: json['full_name'] as String? ?? "",
      pen_name: json['pen_name'] as String? ?? "",
      refered_by: json['refered_by'] as String? ?? "",
      home_address: json['home_address'] as String? ?? "",
      profile_picture_url: json['profile_picture_url'] as String? ?? "",
      phone_number: json['phone_number'] as String? ?? "",
      email: json['email'] as String? ?? "",
      account_number: json['account_number'] as String? ?? "",
      account_name: json['account_name'] as String? ?? "",
      bank_name: json['bank_name'] as String? ?? "",
    )
      ..email_address = json['email_address'] as String
      ..created_at = DateTime.parse(json['created_at'] as String);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'full_name': instance.full_name,
      'pen_name': instance.pen_name,
      'refered_by': instance.refered_by,
      'email_address': instance.email_address,
      'profile_picture_url': instance.profile_picture_url,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'home_address': instance.home_address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'bank_name': instance.bank_name,
      'account_name': instance.account_name,
      'account_number': instance.account_number,
      'created_at': instance.created_at.toIso8601String(),
    };
