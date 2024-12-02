import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/read/story_player.dart';
import 'package:provider/provider.dart';

import '../local/local_books_controller.dart';
import '../local/local_story_model.dart';
import '../main.dart';
import '../models/story_model.dart';
import '../publish/write_edit_screen.dart';
import '../read/story_viewer.dart';

class StoryRepository{


  createStory(
      context,{
        required  String bookId,
        required String storyId,
        required title ,
        required String content,
        required storyCoverImageUrl,
        required Function() whenCompleted,
      }

      )async{

    if(
    title.isEmpty||content.length < 100
    ){
      MainController().showSnackBar(context, "write title and some more content");
    }
    else {
      StoryModel storyModel = StoryModel(title: title,content: content,bookId: bookId,private: false,storyId: storyId,storyCoverImageUrl: storyCoverImageUrl);

      await FirebaseFirestore.instance.collection("story").doc(storyModel.storyId).set(
          storyModel.toJson()).whenComplete(() {
            whenCompleted();
            Navigator.pop(context);

      });
    }
  }

  draftStory(
      context,{
        required  String bookId,
        required String storyId,
        required title ,
        required String content,
        required storyCoverImageUrl,
        required Function() whenCompleted,
      }

      )async{

    if(
    title.isEmpty||content.length < 100
    ){
      MainController().showSnackBar(context, "write title and some more content");
    }
    else {
      StoryModel storyModel = StoryModel(title: title,content: content,bookId: bookId,private: true,storyId: storyId,storyCoverImageUrl: storyCoverImageUrl);

      await FirebaseFirestore.instance.collection("story").doc(storyModel.storyId).set(
          storyModel.toJson()).whenComplete(() {
        whenCompleted();
        Navigator.pop(context);
      });
    }
  }

  updateStory(BuildContext context,{required String storyId,required Map<String,dynamic> data,required Function() whenCompleted })async{
    await FirebaseFirestore.instance.collection("story").doc(storyId).update(data).whenComplete((){
      MainController().showSnackBar(context,"updated");
      whenCompleted();

    });
  }



  readStory(BuildContext context,{required String storyId,required StoryModel story}){

    goto(context,StoryViewer(story: story));

  }
  playStory(BuildContext context,{required String storyId,required StoryModel story,required BookModel book}){

    goto(context,StoryPlayer( bookId: story.bookId, story: story,book: book,));

  }

  writeStory(BuildContext context, {required String storyId}) {
    goto(context, StoryScreenAdapter(storyId:storyId,));

  }

   downloadStory(BuildContext context,StoryModel story,BookModel book, int index) {
    Provider.of<LocalBooksController>(
        context, listen: false).addToStories(
        LocalStoryModel(id: story.storyId,
            title: story.title,
            bookId: story.bookId,
            bookTitle:book.title,
            category: book.category,
            content: story.content,
            part: story.chapterIndex,
            bookCoverImageUrl: book.bookCoverImageUrl,
            date: story.createdAt));
    showToast("Downloaded ${story.title}");
  }
  downloadAllStories(BuildContext context, BookModel book)async{
 QuerySnapshot<Map<String, dynamic>> re  =await FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: book.bookId).get();
   List<StoryModel> stories = re.docs.map((v){
     return StoryModel.fromJson(v.data());
   }).toList();

    stories.forEach((v)async{
    await downloadStory(context, v, book, stories.indexOf(v));
   });
  }



}