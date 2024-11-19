import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/views/book_grid_item.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/publish/publish_write_edit_screen.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/paginated_view.dart';
import '../models/book_model.dart';


class MyBooksIndexScreen extends StatefulWidget {
  const MyBooksIndexScreen({super.key});

  @override
  State<MyBooksIndexScreen> createState() => _MyBooksIndexScreenState();
}

class _MyBooksIndexScreenState extends State<MyBooksIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;

  double size = 10;
  TextStyle titleStyle  = GoogleFonts.merriweather(
    fontSize: 15,
    fontWeight: FontWeight.w900,

  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4 ,vsync: this);
  }
  Widget tabby(String title){
    return paginatedView(
      key:  Key(title),
        query:  FirebaseFirestore.instance.collection("library").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("status",isEqualTo: title).orderBy("createdAt",descending: true),
        child: (datas,index){

          Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
          var book = BookModel.fromJson(json);

          return BookListItem(
            book: book,
            onTap: (){
              goto(context, BookDetailScreen(book: book,bookId: book.bookId,));
            }, id: book.bookId,
            imageUrl: book.bookCoverImageUrl,
            size: size,
            bookUrl: book.bookUrl,
            aboutBook: book.aboutBook,
            title: book.title,
            tags: book.tags,
            genre:  book.category,

          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  TabBar(
          isScrollable: true,

            controller: tabController,
            tabs: [
          Tab(text: "New",),
              Tab(text: "Drafted",),
              Tab(text: "Private",),
              Tab(text: "In Review",),
              Tab(text: "Published",),
              Tab(text: "Rejected",),
        ]),
      ),
      body:
      TabBarView(
          controller: tabController,
          children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            // pod(title:"upload pdf",
            //     icon:Icons.upload_outlined,
            //     onPressed:(){
            //   goto(context, PublishPdfEditScreen());
            //   debugPrint("upload");}),
            pod(title:"write new",
                icon:Icons.edit_outlined,
                onPressed:(){
                  goto(context, PublishWriteEditScreen(book: BookModel(),));
                  debugPrint("write");}),
          ],),
        ),
            tabby(Status.Drafted.name),
            tabby(Status.Private.name),
            tabby(Status.Review.name),
            tabby(Status.Publish.name),
            tabby(Status.Rejected.name),


      ]),
      //upload book or write book
      //drafted book same as above
      //scheduled to release books
      //published book from latest down in scrollview

      //
      bottomNavigationBar: adaptiveAdsView(
          AdHelper.getAdmobAdId(adsName:Ads.addUnitId5)

      ),
    );
  }

 Widget pod({required String title, required IconData icon, required  Function() onPressed}) {
    return GestureDetector(
      onTap: ()=>onPressed(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset("assets/book_cover.png")),
                // Positioned(bottom: 10,left: 0,right: 0,child: Icon(icon,color: Colors.black,size: 35,),)
              ],
            ),
            Text(title,style: GoogleFonts.merriweather(
              fontSize: 12
            ),)
          ],
        ),
      ),
    );
  }
}
