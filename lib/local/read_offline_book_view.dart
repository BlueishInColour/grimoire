import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/read/story_player.dart';
import 'package:grimoire/read/story_viewer.dart';
import 'package:provider/provider.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../local/local_books_controller.dart';
import '../local/local_story_model.dart';
import '../models/story_model.dart';
import '../repository/story_repository.dart';

class ReadOfflineBookView extends StatefulWidget {
  const ReadOfflineBookView({super.key,required this.story,required this.index});
 final LocalStoryModel story;
 final int index;

  @override
  State<ReadOfflineBookView> createState() => _ReadOfflineBookViewState();
}

class _ReadOfflineBookViewState extends State<ReadOfflineBookView>  with TickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: widget.index);
  }
  @override
  Widget build(BuildContext context) {
    LocalStoryModel story = widget.story;
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
               StoryViewer(story: StoryModel(title: story.title,storyId: story.id,bookId: story.bookId,storyCoverImageUrl: "",content: story.content)),

            ///
            ///
            StoryPlayer(bookId:"", story:  StoryModel(title: story.title,storyId: story.id,bookId: story.bookId,storyCoverImageUrl: "",content: story.content),book: BookModel(),)
          ])])
      ,
      bottomNavigationBar:  adaptiveAdsView(
          AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

      ),
    );
  }
}
