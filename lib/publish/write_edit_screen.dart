import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/repository/story_repository.dart';


import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class WriteEditScreen extends StatefulWidget {
  const WriteEditScreen({super.key,required this.bookId,this.story});
  final String bookId;
  final StoryModel? story;

  @override
  State<WriteEditScreen> createState() => _WriteEditScreenState();
}

class _WriteEditScreenState extends State<WriteEditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String imageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            title:Text("New"),
            actions: [
              TextButton(onPressed: (){
                //update book storypart title,storyid, updatedAt

               StoryRepository().createStory(context, bookId: widget.bookId, storyId: Uuid().v1(), title: titleController.text, content: contentController.text,storyCoverImageUrl: c.storyImageCover,
               whenCompleted: (){c.storyModel  = StoryModel();});
              }, child: Text("draft")),
              TextButton(onPressed: (){
                //update book storypart title,storyid, updatedAt

                StoryRepository().draftStory(context, bookId: widget.bookId, storyId: Uuid().v1(), title: titleController.text, content: contentController.text,storyCoverImageUrl: c.storyImageCover,
                whenCompleted: (){c.storyModel  = StoryModel();});


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
