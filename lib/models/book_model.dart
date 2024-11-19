
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "book_model.g.dart";

@JsonSerializable()
class BookModel  {

  BookModel({
    this.bookId = "",

    this.title = "",
    this.aboutBook = "",
    this.authorPenName = "",

    this.bookCoverImageUrl = "",
    this.bookUrl = "",

    this.status = Status.Drafted,
    this.category = "",
    this.subCategory = const [],
    this.tags = const [],
    this.searchTags =const [],

    this.hasStories = false,

    this.approveHardcopyPublishing = false,
    this.language = "",
    this.languageIsoCode = "en",



  });
  String bookId;

  String title;
  String aboutBook;
  String authorPenName;

  String bookCoverImageUrl;
  String bookUrl;

  String category;
  List<String > subCategory;

  List<String> tags;

  bool hasStories;

  Status status;
  bool approveHardcopyPublishing;
  String language;
  String languageIsoCode;


  int timeSpentInMilliSeconds = 0;

  int? readerCount = 0;
  int? pages = 0;

  List<String> searchTags;


  DateTime createdAt  = DateTime.now();
  DateTime? updatedBy = null;

  String createdBy = FirebaseAuth.instance.currentUser?.email ??"";


  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}




@JsonSerializable()
class StoryPart  {

  StoryPart({
    this.title="",
    this.storyId="",
    this.private = true
  });
  String title;
  String storyId;
  bool private;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();


  factory StoryPart.fromJson(Map<String, dynamic> json) => _$StoryPartFromJson(json);

  Map<String, dynamic> toJson() => _$StoryPartToJson(this);
}

enum Status{
  Review,
  Private,
  Drafted,
  Scheduled,
  Publish,
  Rejected,
  Completed,

}

enum BookType{
  Novel,
  Novella,
}