import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/models/story_model.dart';

import '../../models/book_model.dart';

class StoryListItem extends StatefulWidget {
  const StoryListItem({super.key,required this.story,});
  final StoryModel story;
  @override
  State<StoryListItem> createState() => _StoryListItemState();
}

class _StoryListItemState extends State<StoryListItem> {
  @override
  Widget build(BuildContext context) {
    StoryModel story = widget.story;
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        ClipRRect(
          borderRadius:BorderRadius.circular(10),
          child: Image.asset("assets/book_cover.png",
            height: 9*15,
            width: 16*20,
            fit: BoxFit.fill,),
        ),
        SizedBox(height: 5,),
        Text("The Mysterious Library",
            style: GoogleFonts.merriweather(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w700
            )
        ),
        Text("Chapter ${story.chapterIndex}",
            style: GoogleFonts.merriweather(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w700
            )
        ),
        Text(story.title,style: GoogleFonts.merriweather(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.w800


        ),)

      ],
    ));
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_time_format/date_time_format.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grimoire/commons/views/book_list_item.dart';
// import 'package:grimoire/home_books/book_detail_screen.dart';
// import 'package:grimoire/main.dart';
//
// import '../../models/book_model.dart';

class StoryListAdaptiveItem extends StatefulWidget {
  const StoryListAdaptiveItem({super.key,required this.onTap,this.child,this.showDate = true,required this.createdAt,this.isDarkMode =false,required this.storyId,required this.size});
  final String storyId;
  final DateTime createdAt;
  final double size;
  final bool showDate;
  final bool isDarkMode;
  final Function(BookModel)? onTap;
  final Widget Function(StoryModel)?  child;
  @override
  State<StoryListAdaptiveItem> createState() => _StoryListAdaptiveItemState();
}

class _StoryListAdaptiveItemState extends State<StoryListAdaptiveItem> {
  String getDay(){

    DateTime date =widget.createdAt;
    return date.format("D");
  }
  String getDayNumber(){
    DateTime date = widget.createdAt;
    return date.format("jS");
  }

  String getMonth(){

    DateTime date =widget.createdAt;
    return date.format("M");
  }
  String getYear(){

    DateTime date = widget.createdAt;
    return"'${ date.format("y")}";
  }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isDarkMode;
    return  FutureBuilder(
        future: FirebaseFirestore.instance.collection("story").doc(widget.storyId).get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
          {return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 16*widget.size,
              child: Row(
                children: [
                  Container(
                    width:60,

                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height :16*widget.size,
                      child: Row(
                        children: [
                          Container(
                            color:widget.isDarkMode?Colors.white12 : Colors.grey[100],
                            height :16*widget.size,
                            width: 9*widget.size,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );}
          else if(snapshot.hasData && snapshot.data?.data()?.isNotEmpty != null){
            StoryModel story = StoryModel.fromJson(snapshot.data?.data()??{});

            return SizedBox(
              height: 8*widget.size,

              child: Row(
                children: [
                  widget.showDate? SizedBox(
                    width: 60,child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(getDay(),
                            style: GoogleFonts.merriweather(
                                color:isDarkMode?Colors.white60: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 8
                            ),
                          ),
                          Text(getDayNumber(),
                            style: GoogleFonts.merriweather(
                                color: isDarkMode?Colors.white60:Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            ),
                          ),
                          Text(getMonth(),
                            style: GoogleFonts.merriweather(
                                color:isDarkMode?Colors.white60: Colors.black54,
                                fontWeight: FontWeight.w900,
                                fontSize: 23
                            ),
                          ),
                          Text(getYear(),
                            style: GoogleFonts.merriweather(
                                color:isDarkMode?Colors.white60: Colors.black54,
                                fontWeight: FontWeight.w900,
                                fontSize: 10
                            ),
                          ),
                        ],
                      ),
                      widget.child !=null? widget.child!(story):SizedBox()
                    ],
                  ),):SizedBox.shrink(),
                  Expanded(
                    child: StoryListItem(
                    story: story,
                    ),
                  ),
                ],
              ),
            );
          }
          else return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Container(
                  width:80,

                ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height :16*widget.size,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/book_cover.png",
                            height :16*widget.size,
                            width: 9*widget.size,
                          ),

                          SizedBox(width: 10,),
                          Text("This Book is Unavailable.",
                            style: GoogleFonts.merriweather(),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        });
  }
}

