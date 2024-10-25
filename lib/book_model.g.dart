// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      title: json['title'] as String? ?? "",
      aboutBook: json['aboutBook'] as String? ?? "",
      bookCoverImageUrl: json['bookCoverImageUrl'] as String? ?? "",
      bookUrl: json['bookUrl'] as String? ?? "",
      category: json['category'] as String? ?? "",
      subCategory: (json['subCategory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      private: json['private'] as bool? ?? false,
      approveHardcopyPublishing:
          json['approveHardcopyPublishing'] as bool? ?? false,
      language: json['language'] as String? ?? "",
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedBy = json['updatedBy'] == null
          ? null
          : DateTime.parse(json['updatedBy'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'title': instance.title,
      'aboutBook': instance.aboutBook,
      'bookCoverImageUrl': instance.bookCoverImageUrl,
      'bookUrl': instance.bookUrl,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'tags': instance.tags,
      'private': instance.private,
      'approveHardcopyPublishing': instance.approveHardcopyPublishing,
      'language': instance.language,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedBy': instance.updatedBy?.toIso8601String(),
      'createdBy': instance.createdBy,
    };
