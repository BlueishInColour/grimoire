import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
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
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  int selectedTabIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: widget.index);
    setState(() {
      selectedTabIndex = widget.index;
    });
  }
  
  Widget tile(StoryModel story,int index){
    return ListTile(
      onTap: (){
        if(selectedTabIndex==0) StoryRepository().readStory(context, storyId: story.storyId,story: story);
        else  StoryRepository().playStory(context,storyId: story.storyId, story: story,book: widget.book);
      },

      leading: Text("cp ${story.chapterIndex}",style:
      GoogleFonts.crimsonPro(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white70
      ),),
      title: Text(story.title,style: GoogleFonts.crimsonPro(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white70
      ),),
      trailing:  StreamBuilder<bool>(
          stream: Provider.of<LocalBooksController>(context,listen: false).isStoryDownloaded(story.storyId),
          builder: (context, snapshot) {
            if(snapshot.connectionState ==ConnectionState.waiting){return CircularProgressIndicator();}
            else if(snapshot.hasData ) {
              bool isDownloaded = snapshot.data??false;
              return
                isDownloaded?Icon(Icons.download_done_sharp,color: Colors.white70,):
                IconButton(onPressed: () async{
                  await StoryRepository().downloadStory(context,story,widget.book,index);
                },
                    icon: Icon(
                        Icons.download_outlined, size: 14,color: Colors.white70));
            }
            else return Icon(Icons.download_done_sharp,color: Colors.white70);
          }
      )
      ,

    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-200,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white70,
          title: TabBar(
              isScrollable: true,
              controller: tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              onTap: (v){
                setState(() {
                  selectedTabIndex = v;
                });
              },
              unselectedLabelColor: Colors.white54,
              tabs: [Tab(text: "Read",),Tab(text: "Play",)]),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child:FutureBuilder(future: FirebaseFirestore.instance. collection("story").where("bookId",isEqualTo: widget.bookId).count().get(),
                    builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting)return loadWidget(color:Colors.white);
                  else if(snapshot.hasData){
                    int count = snapshot.data?.count ?? 0;
                    double noOfChapterTabs = count /10;
                    int remaims = count%10 != 0?1:0;
                    return ListView.builder(
                        itemCount:count>=1&&count<10?1: noOfChapterTabs.toInt()+remaims,
                        itemBuilder: (context,index){
                      int startCount =  (index*10)+1;
                      int endCount = noOfChapterTabs>index&& noOfChapterTabs<10?index+10:count.toInt();

                      return ListyTile(startCount: startCount, endCount: endCount,bookId: widget.bookId,
                          child: (story,index){
                        return tile(story, index);
                          },);
                    });
                  }
                  else return emptyWidget();
                  
                    })
            )
          ],
        )
        ,
        // bottomNavigationBar:  adaptiveAdsView(
        //     AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

        // ),
      ),
    );
  }


}

// import 'package:flutter/material.dart';

class ListyTile extends StatefulWidget {
  const ListyTile({super.key, required this.startCount, required this.endCount,required this.bookId,required this.child});
final int endCount;
final int startCount;
final String bookId;
final Widget Function(StoryModel,int) child;
  @override
  State<ListyTile> createState() => _ListyTileState();
}

class _ListyTileState extends State<ListyTile> {
  bool showChapters = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: (){
            setState(() {
               showChapters = !showChapters;
            });
          },
          title: Text("Chapter ${widget.startCount.toString()} - Chapter ${widget.endCount.toString()}",
              style:GoogleFonts.montserrat(
    color: Colors.white70,
    fontWeight: FontWeight.w500)
    ),
          trailing:  Icon(showChapters?Icons.keyboard_arrow_down_outlined: Icons.keyboard_arrow_right_outlined, color: Colors.white60,),
        ),
        showChapters?
            paginatedView(
                shrinkWrap: true,
                query: FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: widget.bookId).where("chapterIndex",isGreaterThanOrEqualTo: widget.startCount).where("chapterIndex",isLessThanOrEqualTo: widget.endCount).orderBy("chapterIndex",descending: false),
                child: (datas,index){
              StoryModel story = StoryModel.fromJson(datas[index].data() as Map<String,dynamic>);
              return widget.child(story,index);
                }):SizedBox.shrink()
      ],
    );

  }
}
