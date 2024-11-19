import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/local/local_books_controller.dart';
import 'package:grimoire/local/local_story_model.dart';
import 'package:grimoire/local/read_offline_book_view.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/read/story_player.dart';
import 'package:grimoire/read/story_viewer.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/load_widget.dart';
import '../in_app_purchase/in_app_purchase_controller.dart';
import '../models/story_model.dart';
import 'offline_book_list_item.dart';
class DownloadedIndexScreen extends StatefulWidget {
  const DownloadedIndexScreen({super.key});

  @override
  State<DownloadedIndexScreen> createState() => _DownloadedIndexScreenState();
}

class _DownloadedIndexScreenState extends State<DownloadedIndexScreen> with TickerProviderStateMixin {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(

        builder:(context,c,child)=> Scaffold(
          appBar: AppBar(
            title: Text("Downloads"),
          ),
          body: FutureBuilder(future: LocalBooksController().fetchStories(),
              builder: (context,snapshot){
            if(snapshot.connectionState ==ConnectionState.waiting)return loadWidget();
             else if (snapshot.hasData){
               List<Future<LocalStoryModel>> stories = snapshot.data ??[];
               return ListView.builder(
                   itemCount: stories.length,
                   itemBuilder: (context,index){
                 Future<LocalStoryModel> story = stories[index];
                 return FutureBuilder(future: story, builder: (context,snapshot){
                   if(snapshot.connectionState == ConnectionState.waiting) {

                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         child: Row(
                           children: [
                             image(context, "imageUrl", 14)
                           ],
                         ),
                       ),
                     );
                   }
                   else if(snapshot.hasData){
                     LocalStoryModel? story = snapshot.data;
                     return
                       story == null?SizedBox.shrink():
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GestureDetector(
                           onTap: (){
                             goto(context, StoryViewer(story: StoryModel(title: story.title,storyId: story.id,bookId: story.bookId,storyCoverImageUrl: "",content: story.content)));

                           },
                           child: SizedBox(
                             height: 8*14,
                             // width: MediaQuery.of(context).size.width,
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 image(context, "imageUrl", 14),
                               SizedBox(width: 10,),
                               Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(story.bookTitle +" ${story.part ?? 1}",
                                     style: GoogleFonts.montserrat(
                                       fontSize: 7,
                                       fontWeight: FontWeight.w900,
                                       color: Colors.black54
                                     ),),
                                 
                                     Text(story.title,
                                       style: GoogleFonts.merriweather(
                                           fontSize: 15,
                                         fontWeight: FontWeight.w800
                                       ),),
                                 
                                 
                                 
                                   ],
                                 ),
                               ),
                                 Center(
                                   child: IconButton(onPressed: (){
                                   goto(context, StoryPlayer(story:StoryModel(title: story.title,storyId: story.id,bookId: story.bookId,storyCoverImageUrl: "",content: story.content), bookId: story.bookId,book: BookModel(title: story.bookTitle,bookCoverImageUrl: story.bookCoverImageUrl??""),));
                                   },
                                       icon: Icon(Icons.play_arrow_outlined,color: colorRed,),),
                                 )

                               ],
                             ),
                           ),
                         ),
                       );
                   }
                   else return SizedBox.shrink();
                 });
               });
            }
             else {
               return Center(child: Image.asset("assets/empty.png"),);
            }
              }),
          bottomNavigationBar: adaptiveAdsView(
        AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

    ),
        ),



    );
  }
}


List<String> subSections = ["A-Z","date","size","type",];