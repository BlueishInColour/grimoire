import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/read/story_player.dart';
import 'package:provider/provider.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../local/local_books_controller.dart';
import '../local/local_story_model.dart';
import '../models/story_model.dart';
import '../repository/story_repository.dart';

class ReadBookView extends StatefulWidget {
  const ReadBookView({super.key,required this.bookId,required this.index,required this.book});
  final String bookId;
  final int index;
  final BookModel book;

  @override
  State<ReadBookView> createState() => _ReadBookViewState();
}

class _ReadBookViewState extends State<ReadBookView>  with TickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: widget.index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [Tab(text: "Read",),Tab(text: "Play",)]),
      ),

      body: TabBarView(
           controller: tabController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child:paginatedView(query: FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: widget.bookId).orderBy("createdAt"),
                        child: (datas,index){
                          Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
                          StoryModel story = StoryModel.fromJson(json);
                          return ListTile(
                            onTap: (){StoryRepository().readStory(context, storyId: story.storyId,story: story);},
                            leading: Text( "${story.private?"Drafted": "Chapter"} ${index + 1}",style:GoogleFonts.merriweather()),
                            title: Text(story.title,style: GoogleFonts.merriweather(),),
                            trailing:  StreamBuilder<bool>(
                              stream: Provider.of<LocalBooksController>(context,listen: false).isStoryDownloaded(story.storyId),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState ==ConnectionState.waiting){return CircularProgressIndicator();}
                                else if(snapshot.hasData ) {
                                  bool isDownloaded = snapshot.data??false;
                                  return
                                    isDownloaded?Icon(Icons.download_done_sharp):
                                    IconButton(onPressed: () {
                                    Provider.of<LocalBooksController>(
                                        context, listen: false).addToStories(
                                        LocalStoryModel(id: story.storyId,
                                            title: story.title,
                                            bookId: story.bookId,
                                            bookTitle: widget.book.title,
                                            category: widget.book.category,
                                            content: story.content,
                                            part: index+1,
                                            date: story.createdAt));
                                  },
                                      icon: Icon(
                                        Icons.download_outlined, size: 14,));
                                }
                                else return Icon(Icons.download_done_sharp);
                              }
                            )
                            ,

                          );
                        }))
              ],
            ),

            ///
            ///
           StoryPlayer(bookId:widget.bookId)
          ])
      ,
      bottomNavigationBar:  adaptiveAdsView(
          AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

      ),
    );
  }
}
