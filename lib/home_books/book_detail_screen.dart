import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/commons/buttons/like_button.dart';
import 'package:grimoire/commons/buttons/play_book_button.dart';
import 'package:grimoire/commons/views/book_grid_item.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/constant/CONSTANT.dart';
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
import 'package:grimoire/read/book_menu_view.dart';
import 'package:grimoire/read/story_viewer.dart';
import 'package:grimoire/publish/write_edit_screen.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:grimoire/repository/like_repository.dart';
import 'package:grimoire/repository/story_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/book_list_item.dart';
import '../commons/views/counts_text_view.dart';
import '../commons/views/my_list_view.dart';
import '../models/book_model.dart';
import '../models/history_model.dart';
import '../publish/rewrite_edit_screen.dart';

import 'package:blur/blur.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key, required this.bookId, required this.book});

  final String bookId;
  final BookModel book;
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>
    with TickerProviderStateMixin {
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
    BookModel book = widget.book;

    Widget box({String text = "", Color color = Colors.grey}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: Colors.black54),
          ),
        ),
      );
    }

    Widget boxbox(
        {required Widget text,
        required IconData icon,
        required String title,
        required Color iconColor}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      fontSize: 10, fontWeight: FontWeight.w800),
                ),
                text,
              ],
            )),
      );
    }

    return Consumer<PublishController>(
      builder: (context, c, child) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  image(context, book.bookCoverImageUrl, 30),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    book.title,
                    style: GoogleFonts.crimsonPro(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(book.authorPenName)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  boxbox(
                      iconColor: colorRed,
                      text: likesCount(
                        context,
                        widget.book.bookId,
                      ),
                      icon: Icons.favorite,
                      title: "Likes"),
                  boxbox(
                      iconColor: colorPurple,
                      text: Text(
                        (book.timeSpentInMilliSeconds / 3.6e+6)
                                .round()
                                .toString() +
                            "hrs",
                        style: countStyle,
                      ),
                      icon: Icons.access_time_filled,
                      title: "Read Hours"),
                  boxbox(
                      iconColor: colorBlue,
                      text: chaptersCount(context, widget.book.bookId),
                      icon: Icons.book,
                      title: "Chapters"),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  box(text: book.category, color: Colors.blue.shade50),
                  ...book.subCategory.map((v) {
                    return box(text: v, color: Colors.grey.shade100);
                  })
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: colorRed,
                    width: 7,
                    height: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Synopsis",
                    style: GoogleFonts.crimsonText(
                        fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                book.aboutBook,
                style: GoogleFonts.crimsonText(fontSize: 16),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomBar(),
      ),
      // bottomNavigationBar: adaptiveAdsView(
      //     AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)
      //
      // ),
    );
  }

  Widget bottomBar() {
    // bool isBookMine = widget.book.createdBy == FirebaseAuth.instance.currentUser?.email;
    //
    BookModel book = widget.book;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          LikeButton(
            bookId: book.bookId,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(250, 50)),
                    backgroundColor: WidgetStatePropertyAll(colorRed),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                onPressed: () {
                  showPlayScreen(0);
                },
                child: Text(
                  "Read",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: OutlinedButton.icon(
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(0),
                    side: WidgetStatePropertyAll(
                        BorderSide(color: colorRed, width: 2)),
                    foregroundColor: WidgetStatePropertyAll(colorRed),
                    minimumSize: WidgetStatePropertyAll(Size(250, 50))),
                onPressed: () {
                  showPlayScreen(1);
                },
                icon: Text(
                  "Play",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    color: colorRed,
                  ),
                ),
                label: Icon(
                  Icons.play_arrow,
                  color: colorRed,
                )),
          ),
          SizedBox(
            width: 15,
          ),
          IconButton(
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(CircleBorder(
                      side: BorderSide(color: Colors.black87, width: 2)))),
              onPressed: () {
                showBookMenuView(context, book);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black87,
              ))
        ],
      ),
    );
  }

  void showPlayScreen(index) {
    showModalBottomSheet(
        backgroundColor: Colors.black,
        showDragHandle: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        context: context,
        builder: (context) => ReadBookView(
              bookId: widget.bookId,
              index: index,
              book: widget.book,
            ));
  }
}

showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.black45,
      textColor: Colors.white70,
      gravity: ToastGravity.TOP);
}


// isBookMine&&book.status !=Status.Completed?
// IconButton(
// onPressed: (){
// goto(context, WriteEditScreen(bookId:book.bookId));
// },
// icon: Icon(Icons.add,color: Colors.white70,),):SizedBox.shrink(),
//
//
//
// IconButton(onPressed: (){
// String text = "https://grimoire.live/library/${widget.bookId}";
// Clipboard.setData(ClipboardData(text: text)).whenComplete((){
// showToast("copied '$text'");
// });
// }, icon: Icon(Icons.link,color: Colors.white70,)),