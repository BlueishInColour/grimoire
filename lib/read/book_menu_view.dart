import 'dart:io';

import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/repository/story_repository.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:grimoire/search_and_genre/search_index_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../commons/views/my_list_view.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';
import '../publish/publish_pdf_edit_screen.dart';
import '../publish/publish_rewrite_edit_screen.dart';
import 'package:social_sharing_plus/social_sharing_plus.dart';

class BookMenuView extends StatefulWidget {
  const BookMenuView({super.key,required this.book});
  final BookModel book;

  @override
  State<BookMenuView> createState() => _BookMenuViewState();
}

class _BookMenuViewState extends State<BookMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
          itemCount: tabs(context,widget.book).length,
          itemBuilder: (context,index){
        tab v = tabs(context,widget.book)[index];
        return ListTile(iconColor:v.iconColor,
          onTap:()=> v.onTap(),
          leading: Icon(v.icon),
          title: Text(v.title,style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontWeight: FontWeight.w700,

          ),),
        );
      }),
    );
  }
}
List<tab> tabs (context,BookModel book){
  bool isBookMine =book.createdBy == FirebaseAuth.instance.currentUser?.email;

  return [
    tab(icon: Icons.download_outlined,title: "Download All Chapters", onTap: ()async{
      await StoryRepository().downloadAllStories(context, book);
    }),

    tab(icon: Icons.ios_share,title: "Share", onTap: ()async{

String uri = "https://grimoire.live/library/${book.bookId}";
     // await Share.share(
     //
     //     book.title+"         read at            "  +"$uri",
     // subject:book.aboutBook,);
      await share(book.bookCoverImageUrl, uri);

    }),

    tab(icon: Icons.link,title: "Copy Link", onTap: ()async{
      Clipboard.setData(ClipboardData(text: "https://grimoire.live/library/${book.bookId}")).whenComplete((){
        showToast("Copied");
      });
    }),

    tab(icon: Icons.bookmark_add_outlined,title: "Curate", onTap: (){
      showModalBottomSheet(context: context, builder: (context){
        return    MyListView(bookId: book.bookId,);
      });
    }),

    tab(icon: Icons.bookmarks_outlined,title: "Other books like this", onTap: (){
if(book.category.isEmpty){}
else{
  goto(context, GenreIndexScreen(currentGenre: book.category));
}
    }),

   if(isBookMine) tab(icon: Icons.report_outlined,title: "Report book", onTap: (){
     EasyLauncher.email(email: "blueishincolour@gmail.com",
     subject: "Reporting book id= ${book.bookId}");
   },iconColor: Colors.red),

  ];}


  showBookMenuView(context,BookModel book){
    showModalBottomSheet(context: context, builder: (context){
      return  BookMenuView(book: book,);
    });
  }


  share(String photoUrl,String bookUrl)async {
    Future<Uint8List> uint8list() async {
      if (photoUrl.isNotEmpty) {
        final http.Response responseData = await http.get(Uri.parse(photoUrl));
        return responseData.bodyBytes;
      }
      else {
        var ress = await rootBundle.load('assets/book_cover.png');
        return ress.buffer.asUint8List();
      }
      var unint = await uint8list();
      var buffer = unint.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/img').writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      const SocialPlatform platform = SocialPlatform.facebook;
      String? _mediaPath; // add image or video path
      List<String> _mediaPaths = [ file.path]; // add image or video paths
      bool isMultipleShare = true;

      // isMultipleShare
      //     ? await SocialSharingPlus.shareToSocialMediaWithMultipleMedia(
      //   platform,
      //   media: _mediaPaths,
      //   content: content,
      //   isOpenBrowser: false,
      //   onAppNotInstalled: () {
      //     showToast('${platform.name} is not installed.');
      //   },
      // )
      //     :
      await SocialSharingPlus.shareToSocialMedia(
        platform,
        "Hey, This read this book at $bookUrl",
        media: _mediaPath,
        isOpenBrowser: true,
      );
    }
  }