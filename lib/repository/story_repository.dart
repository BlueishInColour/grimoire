import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/main_controller.dart';

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

  writeStory(BuildContext context, {required String storyId}) {
    goto(context, StoryScreenAdapter(storyId:storyId,));

  }


}