import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:uuid/uuid.dart';

import '../models/book_model.dart';
import '../commons/views/crop_image_screen.dart';

class PublishController extends MainController{
  BookModel _bookModel = BookModel();
BookModel get bookModel => _bookModel;
set bookModel(v){_bookModel =v;notifyListeners();}

String _bookFilePath = "Choose Book in PDF Format";
String _bookCoverPhotoPath = "Choose Book Cover Picture";
List<String> _tags = [];

String get bookFilePath => _bookFilePath;
String get bookCoverPhotoPath => _bookCoverPhotoPath;

String get bookUrl => bookModel.bookUrl;
String get bookCoverImageUrl => bookModel.bookCoverImageUrl;
String get title  => bookModel.title;
String get aboutBook  => bookModel.title;
String get category => bookModel.category;
List<String> get tags => _tags;
String get language => bookModel.language;
bool get approveHardcopyPublishing => bookModel.approveHardcopyPublishing;
Status get status => bookModel.status;


set bookFilePath(v){_bookFilePath = v;notifyListeners();}
set bookCoverPhotoPath(v){_bookCoverPhotoPath = v;notifyListeners();}

set bookUrl(v){bookModel.bookUrl =v;notifyListeners();}
set bookCoverImageUrl(v){bookModel.bookCoverImageUrl =v;notifyListeners();}
set title(v){bookModel.title= v;notifyListeners();}
set aboutBook(v){bookModel.aboutBook= v;notifyListeners();}
set category(v){bookModel.category= v;notifyListeners();}
  set status(v){bookModel.status = v;notifyListeners();}

addToTag(v){_tags.add(v);bookModel.tags =_tags;notifyListeners();}
removeFromTag(v){_tags.remove(v);bookModel.tags =_tags;notifyListeners();}


set language(v){bookModel.language= v;notifyListeners();}
set approveHardcopyPublishing(v){bookModel.approveHardcopyPublishing= v;notifyListeners();}


chooseBook(BuildContext context)async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: false,

  );

  if (result != null) {
    File file = File(result.files.single.path!);
    bookFilePath = file.path;
  } else {
    // User canceled the picker
  }
}

chooseBookCoverPhoto(BuildContext context)async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
      allowMultiple: false

  );


  if (result != null) {
    File file = File(result.files.single.path!);
    bookCoverPhotoPath = file.path;
    goto(context, CropImageScreen(ratio: Ratio(width: 5, height: 8),afterCropped: (image){
      uploadListOfMemoryImage(context, medias: [image],
          afterOneUpload: (v){bookCoverImageUrl = v;},
          afterTotalUpload: (){Navigator.pop(context);},
          isFailed: (){showSnackBar(context, "Failed to upload cropped image");});
    },));

  } else {
    // User canceled the picker
  }
}



  StoryModel storyModel = StoryModel();

  String get storyId=> storyModel.storyId;
  String get storyBookId=> storyModel.bookId;
  String get storyTitle=> storyModel.title;
  String get storyContent=> storyModel.title;
  String get storyImageCover=> storyModel.storyCoverImageUrl;
  DateTime get storyCreatedAt => storyModel.createdAt;

  set storyId(v){storyModel.storyId =v;notifyListeners();}
  set storyBookId(v){storyModel.bookId =v;notifyListeners();}
  set storyTitle(v){storyModel.title =v;notifyListeners();}
  set storyContent(v){storyModel.content =v;notifyListeners();}
  set storyImageCover(v){storyModel.storyCoverImageUrl =v;notifyListeners();}
  set storyCreatedAt(v){storyModel.createdAt =v;notifyListeners();}

  chooseStoryCoverPhoto(BuildContext context)async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false

    );


    if (result != null) {
      File file = File(result.files.single.path!);
      bookCoverPhotoPath = file.path;
      goto(context, CropImageScreen(ratio: Ratio(width: 16, height: 9),afterCropped: (image){
        uploadListOfMemoryImage(context, medias: [image],
            afterOneUpload: (v){storyImageCover = v;},
            afterTotalUpload: (){Navigator.pop(context);},
            isFailed: (){showSnackBar(context, "Failed to upload cropped image");});
      },));

    } else {
      // User canceled the picker
    }
  }


}