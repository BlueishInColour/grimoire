import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/models/story_model.dart';


import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:provider/provider.dart';

import '../repository/story_repository.dart';


class RewriteEditScreen extends StatefulWidget {
  const RewriteEditScreen({super.key,required this.bookId,required this.story});
  final String bookId;
  final StoryModel story;

  @override
  State<RewriteEditScreen> createState() => _RewriteEditScreenState();
}

class _RewriteEditScreenState extends State<RewriteEditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  setBook(){

    titleController.text = widget.story?.title ??"";
    contentController.text = widget.story?.content ??"";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setBook();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PublishController>(
      builder:(context,c,child)=> NestedScrollView(

        headerSliverBuilder: (ctx,_)=>[
          SliverAppBar(
            backgroundColor: Colors.grey[100],
            pinned:false,
            floating: true,
            snap: true,
            automaticallyImplyLeading: true,
            title: Text("Edit"),
            actions: [
              TextButton(onPressed: (){
                //update book storypart title,storyid, updatedAt


                StoryRepository().updateStory(context,
                    storyId: widget.story.storyId,
                    data: {
                      "title" : titleController.text,
                      "private":true,
                      "content" :contentController.text,
                      "updatedAt":DateTime.now().toIso8601String()
                    }
                    , whenCompleted: (){c.storyModel  = StoryModel();});

              }, child: Text("draft")),
              TextButton(onPressed: (){
                //update book storypart title,storyid, updatedAt


                StoryRepository().updateStory(context,
                    storyId: widget.story.storyId,
                    data: {
                  "title" : titleController.text,
                      "private":false,
                      "content" :contentController.text,
                      "updatedAt":DateTime.now().toIso8601String()
                    }
                    , whenCompleted: (){c.storyModel  = StoryModel();});

              }, child: Text("publish")),
            ],
          ),

          SliverAppBar(
            backgroundColor: Colors.grey[100],
            pinned:false,
            floating: true,
            snap: true,
            automaticallyImplyLeading: false,
            title: TextField(
              controller: titleController,
              style: GoogleFonts.merriweather(),

              // onChanged: (v){c.storyTitle = v;},
              decoration: InputDecoration(
                  hintText: "enter "
                      "title .....",
                  hintStyle: GoogleFonts.merriweather()
              ),
            ),

          ),
          SliverAppBar(
            pinned:false,
            floating: false,
            snap: false,
            backgroundColor: Colors.grey[100],
            automaticallyImplyLeading: false,
            title: TextButton.icon(onPressed: (){
              c.chooseStoryCoverPhoto(context);
            },icon: Icon(Icons.image_outlined) ,label: Text(c.storyImageCover.isNotEmpty?"Change Chapter Cover Picture":"Choose Chapter Cover Picture")),
          ),
          c.storyImageCover.isNotEmpty?SliverAppBar(
              toolbarHeight: 200,

              pinned:false,
              floating: false,
              snap: false,
              backgroundColor: Colors.grey[100],
              automaticallyImplyLeading: false,

              title: Image.network(c.storyImageCover)):SliverToBoxAdapter(),

        ],
        body: Scaffold(
          body:TextField(
            style: GoogleFonts.merriweather(),
            controller: contentController,
            // onChanged: (v){c.storyContent = v;},

            minLines: 100,
            maxLines: 4000,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: "write .....",
                hintStyle: GoogleFonts.merriweather(
                    color: Colors.black
                )
            ),
          ),
        ),


      ),
    );
  }
}
