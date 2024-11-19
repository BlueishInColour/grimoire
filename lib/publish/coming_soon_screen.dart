import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/commons/buttons/calender_button.dart';
import 'package:grimoire/commons/buttons/follow_button.dart';
import 'package:grimoire/commons/views/story_list_item.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/calender_event.dart';
import 'package:grimoire/models/follow_model.dart';
import 'package:grimoire/models/scheduled_model.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/repository/calender_repository.dart';
import 'package:grimoire/repository/coming_soon_repository.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:grimoire/repository/follow_repository.dart';

import '../commons/adapters/book_grid_adapter_item.dart';
import '../commons/adapters/book_list_adapter_item.dart';
import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> with TickerProviderStateMixin{



  late TabController tabController;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
        headerSliverBuilder: (context,_)=>[
          SliverAppBar(
            pinned: false,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title:Row
              (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.offline_bolt_rounded,color: colorBlue,),
                SizedBox(width: 5,),
                Text("Coming Soon ....",
                  style: GoogleFonts.montserrat(
                      color: colorBlue,
                      fontWeight: FontWeight.w800
                  ),),
              ],
            ),
          ),

          SliverAppBar(
            pinned:  true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: TabBar(
                controller: tabController,
                isScrollable: false,
                tabAlignment: TabAlignment.center,
                labelColor: colorBlue,
                indicatorColor: colorBlue,
                unselectedLabelColor: Colors.white54,
                tabs: [
                  Tab(text:"Books",),
                  Tab(text: "Stories",), //other subtabs like all, favorites,
                ]),

          ),
        ],

        body:TabBarView(
            controller: tabController,
            children: [
              BookComingSoonTab(),
              StoriesComingSoonTab(),


            ])
    );
  }
}

// import 'package:flutter/material.dart';

class BookComingSoonTab extends StatefulWidget {
  const BookComingSoonTab({super.key});
  @override
  State<BookComingSoonTab> createState() => _BookComingSoonTabState();
}

class _BookComingSoonTabState extends State<BookComingSoonTab> with TickerProviderStateMixin {
  Sort sort = Sort.All;
  late TabController sortController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortController = TabController(length: Sort.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:  TabBar(
          controller: sortController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: colorBlue,
          indicatorColor: colorBlue,
          unselectedLabelColor: Colors.white54,
          onTap: (v){
            setState(() {
              sort = Sort.values[v];
            });
          },
          tabs:Sort.values.map((v){
            return
              Tab(text:v.name,);
          }).toList()
      ),
      body: TabBarView(

          controller: sortController,
          children: [

            paginatedView(
                key: Key("book"+sort.name),
                query: ComingSoonRepository().bookRef,//.bookRef,
                child: (datas, index) {
                  Map<String, dynamic> json = datas[index].data() as Map<
                      String,
                      dynamic>;
                  ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                  return BookListAdapterItem(
                    child: (book) {
                      return   Column(
                        children: [
                          FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                          SizedBox(height: 10,),
                          CalenderButton(
                            book: book,
                            startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                            endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                        ],
                      );
                    },
                    isDarkMode: true,
                    onTap: (book){
                    },
                    bookId: scheduledModel.id,
                    size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);}),

            paginatedView(
                query: FollowRepository().ref,
                child: (datas,index) {
                  FollowModel follow  = FollowModel.fromJson(datas[index].data()as Map<String,dynamic>);
                  return  paginatedView(
                      shrinkWrap: true,

                      key: Key("book"+sort.name),
                      query: ComingSoonRepository().bookRef.where("createdBy",isEqualTo: follow.followedAt),//.bookRef,
                      child: (datas, index) {
                        Map<String, dynamic> json = datas[index].data() as Map<
                            String,
                            dynamic>;
                        ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                        return BookListAdapterItem(
                          child: (book) {
                            return   Column(
                              children: [
                                FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                                SizedBox(height: 10,),
                               CalenderButton(
                            book: book,
                            startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                            endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                              ],
                            );
                          },
                          isDarkMode: true,
                          onTap: (book){
                          },
                          bookId: scheduledModel.id,
                          size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);});
                }
            ),
            paginatedView(
                query: CalenderBookRepository().ref,
                child: (datas, index) {
                  Map<String, dynamic> json = datas[index].data() as Map<
                      String,
                      dynamic>;
                  CalenderEvent event = CalenderEvent.fromJson(json);
                  return paginatedView(query: ComingSoonRepository().bookRef.where("bookId",isEqualTo: event.id),
                      shrinkWrap: true,
                      child: (datas,index){
                        Map<String, dynamic> json = datas[index].data() as Map<
                            String,
                            dynamic>;
                        ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                       return BookListAdapterItem(
                          child: (book) {
                            return   Column(
                              children: [
                                FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                                SizedBox(height: 10,),
                                CalenderButton(
                                  book: book,
                                  startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                                  endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                              ],
                            );
                          },
                          isDarkMode: true,
                          onTap: (book){
                          },
                          bookId: scheduledModel.id,
                          size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);
                      });})
          ]),
    );
  }
}



// import 'package:flutter/material.dart';

class StoriesComingSoonTab extends StatefulWidget {
  const StoriesComingSoonTab({super.key,});
  @override
  State<StoriesComingSoonTab> createState() => _StoriesComingSoonTabState();
}

class _StoriesComingSoonTabState extends State<StoriesComingSoonTab> with TickerProviderStateMixin {
  Sort sort = Sort.All;
  late TabController sortController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortController = TabController(length: Sort.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:  TabBar(
          controller: sortController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: colorBlue,
          indicatorColor: colorBlue,
          unselectedLabelColor: Colors.white54,
          onTap: (v){
            setState(() {
              sort = Sort.values[v];
            });
          },
          tabs:Sort.values.map((v){
            return
              Tab(text:v.name,);
          }).toList()
      ),
      body:TabBarView(

          controller: sortController,
          children: [
            paginatedView(
                key: Key("story"+sort.name),
                query: ComingSoonRepository().StoryRef,//.bookRef,
                child: (datas, index) {
                  Map<String, dynamic> json = datas[index].data() as Map<
                      String,
                      dynamic>;
                  ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                  return StoryListAdaptiveItem(
                    child: (story) {
                      return   Column(
                        children: [
                          FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                          SizedBox(height: 10,),
                          CalenderButton(
                            isStory:true,
                            storyModel : story,
                            book: BookModel(),
                            startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                            endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                        ],
                      );
                    },
                    isDarkMode: true,
                    onTap: (book){
                    },
                    storyId: scheduledModel.id,
                    size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);}),

            paginatedView(
                query: FollowRepository().ref,
                child: (datas,index) {
                  FollowModel follow  = FollowModel.fromJson(datas[index].data()as Map<String,dynamic>);
                  return  paginatedView(
                      shrinkWrap: true,

                      key: Key("story"+sort.name),
                      query: ComingSoonRepository().StoryRef.where("createdBy",isEqualTo: follow.followedAt),//.bookRef,
                      child: (datas, index) {
                        Map<String, dynamic> json = datas[index].data() as Map<
                            String,
                            dynamic>;
                        ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                        return StoryListAdaptiveItem(
                          child: (story) {
                            return   Column(
                              children: [
                                FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                                SizedBox(height: 10,),
                                CalenderButton(
                                  isStory:true,
                                  storyModel: story,
                                  book: BookModel(
                                  ),
                                  startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                                  endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                              ],
                            );
                          },

                          isDarkMode: true,
                          onTap: (book){
                          },
                          storyId: scheduledModel.id,
                          size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);});
                }
            ),
            paginatedView(
                query: CalenderBookRepository().ref,
                child: (datas, index) {
                  Map<String, dynamic> json = datas[index].data() as Map<
                      String,
                      dynamic>;
                  CalenderEvent event = CalenderEvent.fromJson(json);
                  return paginatedView(query: ComingSoonRepository().StoryRef.where("bookId",isEqualTo: event.id),
                      shrinkWrap: true,
                      child: (datas,index){
                        Map<String, dynamic> json = datas[index].data() as Map<
                            String,
                            dynamic>;
                        ScheduledModel scheduledModel = ScheduledModel.fromJson(json);
                        return StoryListAdaptiveItem(
                          child: (story) {
                            return   Column(
                              children: [
                                FollowButton(emailAddress: scheduledModel.createdBy,size: 24,),
                                SizedBox(height: 10,),
                                CalenderButton(
                                  isStory:true,
                                  storyModel:story,
                                  book: BookModel(),
                                  startDate: scheduledModel.releasedOn!.subtract(Duration(days: 1)),
                                  endDate:scheduledModel.releasedOn!.add(Duration(days: 1)), scheduledModel: scheduledModel, )

                              ],
                            );
                          },
                          isDarkMode: true,
                          onTap: (book){
                          },
                          storyId: scheduledModel.id,
                          size: 25, createdAt: scheduledModel.releasedOn??DateTime.now(),);
                      });})
          ]),
    );
  }
}



addToCalenderEvent(
    {
      required BookModel book,
      required DateTime startDate,
      required DateTime endDate,
      bool isStory = false,
      StoryModel? story,

    }
    )async{

  final Event event = Event(
    title: 'Grimoire: ${book.title} Releases',
    description: '${book.aboutBook}',
    location: isStory?'https://grimoire.live/story/${story?.storyId}':'https://grimoire.live/library/${book.bookId}',
    startDate: startDate,
    endDate:endDate,
    iosParams: IOSParams(
      reminder: Duration(/* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
      url:isStory?'https://grimoire.live/story/${story?.storyId}': 'https://grimoire.live/library/${book.bookId}', // on iOS, you can set url to your event.
    ),
    androidParams: AndroidParams(
      emailInvites: [], // on Android, you can add invite emails to your event.
    ),
  );

  bool done = await  Add2Calendar.addEvent2Cal(event);
  if(done == true) {
    if(isStory){
      await CalenderStoryRepository()
          .addToCalender(story?.storyId??"", startDate, endDate);
    }
    else await CalenderBookRepository()
        .addToCalender(book.bookId, startDate, endDate);
  }
}

enum Sort{
  All,
  FollowedWriters,
  // LikedBooks,
  InCalender
}