// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      bookId: json['bookId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      aboutBook: json['aboutBook'] as String? ?? "",
      authorPenName: json['authorPenName'] as String? ?? "",
      bookCoverImageUrl: json['bookCoverImageUrl'] as String? ?? "",
      bookUrl: json['bookUrl'] as String? ?? "",
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']) ??
          Status.Drafted,
      category: json['category'] as String? ?? "",
      subCategory: (json['subCategory'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      searchTags: (json['searchTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasStories: json['hasStories'] as bool? ?? false,
      approveHardcopyPublishing:
          json['approveHardcopyPublishing'] as bool? ?? false,
      language: json['language'] as String? ?? "",
      languageIsoCode: json['languageIsoCode'] as String? ?? "en",
    )
      ..timeSpentInMilliSeconds =
          (json['timeSpentInMilliSeconds'] as num).toInt()
      ..readerCount = (json['readerCount'] as num?)?.toInt()
      ..pages = (json['pages'] as num?)?.toInt()
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedBy = json['updatedBy'] == null
          ? null
          : DateTime.parse(json['updatedBy'] as String)
      ..createdBy = json['createdBy'] as String;

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'title': instance.title,
      'aboutBook': instance.aboutBook,
      'authorPenName': instance.authorPenName,
      'bookCoverImageUrl': instance.bookCoverImageUrl,
      'bookUrl': instance.bookUrl,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'tags': instance.tags,
      'hasStories': instance.hasStories,
      'status': _$StatusEnumMap[instance.status]!,
      'approveHardcopyPublishing': instance.approveHardcopyPublishing,
      'language': instance.language,
      'languageIsoCode': instance.languageIsoCode,
      'timeSpentInMilliSeconds': instance.timeSpentInMilliSeconds,
      'readerCount': instance.readerCount,
      'pages': instance.pages,
      'searchTags': instance.searchTags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedBy': instance.updatedBy?.toIso8601String(),
      'createdBy': instance.createdBy,
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

StoryPart _$StoryPartFromJson(Map<String, dynamic> json) => StoryPart(
      title: json['title'] as String? ?? "",
      storyId: json['storyId'] as String? ?? "",
      private: json['private'] as bool? ?? true,
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);

Map<String, dynamic> _$StoryPartToJson(StoryPart instance) => <String, dynamic>{
      'title': instance.title,
      'storyId': instance.storyId,
      'private': instance.private,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
