
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part "book_model.g.dart";

@JsonSerializable()
class BookModel  {

  BookModel({
    this.title = "",
    this.aboutBook = "",
    this.authorPenName = "",

    this.bookCoverImageUrl = "",
    this.bookUrl = "",

    this.category = "",
    this.subCategory = const [],
    this.tags = const [],
    this.searchTags =const [],


    this.private=false,
    this.approveHardcopyPublishing = false,
    this.language = "",



  });
  String title;
  String aboutBook;
  String authorPenName;

  String bookCoverImageUrl;
  String bookUrl;

  String category;
  List<String > subCategory;

  List<String> tags;

  bool private;
  bool approveHardcopyPublishing;
  String language;


  String readHours = "";
  int readerCount = 0;
  int pages = 0;
  bool isCompleted = true;
  List<String> searchTags;


  DateTime createdAt  = DateTime.now();
  DateTime? updatedBy = null;

  String createdBy = FirebaseAuth.instance.currentUser?.email ??"";


  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}