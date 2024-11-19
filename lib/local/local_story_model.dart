import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'local_story_model.g.dart';

@HiveType(typeId: 1)
class LocalStoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;


  @HiveField(2)
  final String category;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String bookId;

  @HiveField(6)
  final String bookTitle;

  @HiveField(7)
  final int? part;

  @HiveField(8)
  final String? bookCoverImageUrl;




  LocalStoryModel({
    required String? id,
    required this.title,
    required this.bookId,
    required this.bookTitle,
    required this.category,
    required this.content,
    required this.date,
    required this.bookCoverImageUrl,
     this.part =1
  }) : id = id ?? const Uuid().v4();  // Generate UUID only if id is not provided
}
