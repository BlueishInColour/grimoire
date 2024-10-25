import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:grimoire/book_model.dart';
import 'package:grimoire/main_controller.dart';

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
bool get private => bookModel.private;


set bookFilePath(v){_bookFilePath = v;notifyListeners();}
set bookCoverPhotoPath(v){_bookCoverPhotoPath = v;notifyListeners();}

set bookUrl(v){bookModel.bookUrl =v;notifyListeners();}
set bookCoverImageUrl(v){bookModel.bookCoverImageUrl =v;notifyListeners();}
set title(v){bookModel.title= v;notifyListeners();}
set aboutBook(v){bookModel.aboutBook= v;notifyListeners();}
set category(v){bookModel.category= v;notifyListeners();}

addToTag(v){_tags.add(v);bookModel.tags =_tags;notifyListeners();}
removeFromTag(v){_tags.remove(v);bookModel.tags =_tags;notifyListeners();}


set language(v){bookModel.language= v;notifyListeners();}
set approveHardcopyPublishing(v){bookModel.approveHardcopyPublishing= v;notifyListeners();}
set private(v){bookModel.private= v;notifyListeners();}


chooseBook()async{
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
chooseBookCoverPhoto()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
      allowMultiple: false

  );


  if (result != null) {
    File file = File(result.files.single.path!);
    bookCoverPhotoPath = file.path;
  } else {
    // User canceled the picker
  }
}
publishBook(
    context

    )async{
  bookModel.searchTags = title.split(" ");
 await uploadListOfImage(context, medias: [File(bookFilePath)], afterOneUpload: (v){bookUrl=v;}  , afterTotalUpload: (){}, isFailed: (){showSnackBar(context, "failed to upload document asset");changeLoading(context, false);});
 await uploadListOfImage(context, medias: [File(bookCoverPhotoPath)], afterOneUpload: (v){bookCoverImageUrl=v;}  , afterTotalUpload: (){}, isFailed: (){showSnackBar(context, "failed to upload book cover picture");changeLoading(context, false);});

await FirebaseFirestore.instance.collection("library").add(bookModel.toJson()).whenComplete((){
  bookModel = BookModel();
});
changeLoading(context, false);

}
}