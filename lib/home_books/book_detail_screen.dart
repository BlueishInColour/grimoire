import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/commons/buttons/play_book_button.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/home_books/book_stats_view.dart';
import 'package:grimoire/home_books/read_book_view.dart';
import 'package:grimoire/home_books/review_and_ratings_view.dart';
import 'package:grimoire/local/local_books_controller.dart';
import 'package:grimoire/local/local_story_model.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/review_model.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/publish/publish_pdf_edit_screen.dart';
import 'package:grimoire/publish/publish_rewrite_edit_screen.dart';
import 'package:grimoire/publish/publish_write_edit_screen.dart';
import 'package:grimoire/read/story_viewer.dart';
import 'package:grimoire/publish/write_edit_screen.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:grimoire/repository/story_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/book_list_item.dart';
import '../commons/views/my_list_view.dart';
import '../models/book_model.dart';
import '../models/history_model.dart';
import '../publish/rewrite_edit_screen.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key,required this.bookId , required this.book});

  final String bookId;
  final BookModel book;
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> with TickerProviderStateMixin {


  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tabController = TabController(length: 3, vsync: this);
    BookRepository().setHistory(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    bool isBookMine = widget.book.createdBy == FirebaseAuth.instance.currentUser?.email;

    BookModel book = widget.book;
    return Consumer<PublishController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            isBookMine?
            IconButton(
                icon: Icon(EneftyIcons.edit_2_outline,color: Colors.black,),
                onPressed: (){
                  goto(context, !widget.book.hasStories? PublishRewriteEditScreen(book: widget.book,):PublishPdfEditScreen());
                },)
            :SizedBox.shrink(),

          ],

),
          body :NestedScrollView(
              headerSliverBuilder: (context,_) => [

                SliverAppBar(
                  toolbarHeight: 200,
                  backgroundColor: Colors.grey[100],
                  automaticallyImplyLeading: false,

                  title: SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        image(context,book.bookCoverImageUrl,10),

                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(book.title,
                                maxLines: 5,
                                style: GoogleFonts.merriweather(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700
                                ),
                              ),


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // bottom: AppBar(
                  //
                  //   automaticallyImplyLeading: false,
                  //   title: SizedBox(
                  //     height: 50,
                  //     child: ListView(
                  //       scrollDirection: Axis.horizontal,
                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //       children:  [
                  //
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //           children: [
                  //
                  //                 TextButton.icon(
                  //                 icon: Icon(book.private?Icons.upload_outlined:Icons.done),
                  //                 onPressed: ()async{
                  //                   book.private?
                  //                   await FirebaseFirestore.instance.collection("library").doc(book.bookId).update(
                  //                       {"private":false}).whenComplete((){Navigator.pop(context);}):
                  //                 await FirebaseFirestore.instance.collection("library").doc(book.bookId).update(
                  //                     {"private":true}).whenComplete((){Navigator.pop(context);});},
                  //                 label: Text(book.private?"Publish": "Un-publish")),
                  //
                  //             TextButton.icon(onPressed: ()async{
                  //               debugPrint(book.isCompleted.toString());
                  //
                  //               if(book.isCompleted == false){
                  //              await   BookRepository().updateBook(context, bookId: book.bookId, data: {"isCompleted":true}).whenComplete((){Navigator.pop(context);});
                  //               }
                  //               else{
                  //                 await   BookRepository().updateBook(context, bookId: book.bookId, data: {"isCompleted":false}).whenComplete((){Navigator.pop(context);});
                  //
                  //               }
                  //             }, icon: Icon(book.isCompleted??false?Icons.done_all:Icons.check),label: Text(book.isCompleted??false?"Marked As Completed":"Mark As Complete"))
                  //           ],
                  //         )
                  //             :SizedBox.shrink()
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
                // SliverAppBar(
                //   automaticallyImplyLeading: false,
                //   title:  SizedBox(
                //     height: 40,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         ElevatedButton(
                //           onPressed: (){c.readBook(context, bookId: book.bookId, bookPath: book.bookUrl,isFile: false);},
                //           child: FutureBuilder(
                //               future: FirebaseFirestore.instance.collection("history").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("bookId",isEqualTo: widget.bookId).get(),
                //
                //               builder: (context, snapshot) {
                //                 if(snapshot.connectionState == ConnectionState.waiting){
                //                   return Text("read");
                //                 }
                //                 else if(snapshot.data?.docs.isNotEmpty ?? false){
                //                   HistoryModel historyModel = HistoryModel.fromJson(snapshot.data?.docs.first.data() ??{});
                //                   bool historyExists = historyModel.bookId == widget.bookId;
                //
                //                   return Text(historyExists?"Continue":"Read");
                //                 }
                //                 else return Text("read");
                //               }
                //           ),
                //           style: ButtonStyle(
                //               shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                //           ),
                //         ),
                //         DownloadButton(
                //             color: Colors.white70,
                //             bookUrl: book.bookCoverImageUrl, title: book.title),
                //         BookmarkButton(bookId: book.bookId),
                //
                //         PlayBookButton(
                //             filePath: book.bookUrl,
                //             isFile: false),
                //         SizedBox(width: 10),
                //       ],
                //     ),
                //   ),
                //
                // )
              ],

              body: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabs: [
                        Tab(text: "About Book",),
                        Tab(text: "Reviews & Ratings",),
                        Tab(text: "Stats",),
                      ]),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:TabBarView(
                        controller: tabController,
                        children: [
                          ListView(
                            children: [



                              Text(book.aboutBook,
                                style: GoogleFonts.merriweather(
                                    fontSize: 13
                                ),)
                            ],
                          ),
                         ReviewAndRatingsView(bookId: widget.bookId,),
                          BookStatsView(bookId:widget.bookId)
                        ])
                ),
                bottomNavigationBar:                       bottomBar(),

              ),

          ),
        bottomNavigationBar: adaptiveAdsView(
            AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

        ),


      ),
    );
  }

 Widget bottomBar() {
   bool isBookMine = widget.book.createdBy == FirebaseAuth.instance.currentUser?.email;

   BookModel book = widget.book;
    return  ConstrainedBox(
      constraints: BoxConstraints(
        // maxHeight: 100
      ),
      child: BottomBar(child:(fontSize,iconSize)=>Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextButton(

                  onPressed: (){
                    showPlayScreen(0);
                  },
                  child: Text("Read",
                    style:   GoogleFonts.merriweather(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: fontSize
                    ),)),
            ),
            VerticalDivider(endIndent: 10,indent: 10,),

            IconButton(onPressed: (){

           showPlayScreen(1);
            }, icon: Icon(Icons.play_arrow_outlined,size: iconSize,color: Colors.white70,)
            ),
            IconButton(onPressed: (){
              showModalBottomSheet(context: context, builder: (context){
                return    MyListView(bookId: widget.bookId,);
              });
            }, icon: Icon(Icons.bookmark_add_outlined,size: iconSize,color: Colors.white70,)
            ),
            isBookMine&&book.status !=Status.Completed?
            IconButton(
              onPressed: (){
                goto(context, WriteEditScreen(bookId:book.bookId));
              },
              icon: Icon(Icons.add,size: iconSize,color: Colors.white70,),):SizedBox.shrink(),



            IconButton(onPressed: (){
              String text = "https//:grimoire.live/library/${widget.bookId}";
              Clipboard.setData(ClipboardData(text: text)).whenComplete((){
                showToast("copied '$text'");
              });
            }, icon: Icon(Icons.link,size: iconSize,color: Colors.white70,)),
             ],
        ),
      )),
    );
 }

  void showPlayScreen(index) {
    showModalBottomSheet(

      showDragHandle: true,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),

        context: context, builder: (context)=>ReadBookView(bookId: widget.bookId,index:index,book: widget.book,));

  }
}

showToast(String text){
  Fluttertoast.showToast(
      msg: text,
  );
}
