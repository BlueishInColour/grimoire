import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/read/story_viewer.dart';

import '../../home_books/book_detail_screen.dart';
import '../../models/book_model.dart';

class StoryScreenAdapter extends StatelessWidget {
  const StoryScreenAdapter({super.key,required this.storyId});
  final String storyId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("story").doc(storyId).get(),
        builder: (context,snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return loadWidget();
          }
          else if(snapshot.hasData){

            Map<String,dynamic> json = snapshot.data?.data() as Map<String,dynamic>;
            StoryModel storyModel = StoryModel.fromJson(json);
            return StoryViewer(story: storyModel,);
          }
          else{
            return Image.asset("assets/empty");
          }
        });
  }
}
