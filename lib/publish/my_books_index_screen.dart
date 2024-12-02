
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/views/book_grid_item.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/tab_count.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/local/downloaded_index_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/publish/publish_rewrite_edit_screen.dart';
import 'package:grimoire/publish/publish_write_edit_screen.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/paginated_view.dart';
import '../constant/CONSTANT.dart';
import '../models/book_model.dart';


class MyBooksIndexScreen extends StatefulWidget {
  const MyBooksIndexScreen({super.key});

  @override
  State<MyBooksIndexScreen> createState() => _MyBooksIndexScreenState();
}

class _MyBooksIndexScreenState extends State<MyBooksIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  double size = 14;
  TextStyle titleStyle  = GoogleFonts.merriweather(
    fontSize: 15,
    fontWeight: FontWeight.w900,

  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 6 ,vsync:this,initialIndex:0);
  }
  Widget tabby(String title){
    return paginatedView(
      key:  Key(title),
        query:  FirebaseFirestore.instance.collection("library").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("status",isEqualTo: title).orderBy("createdAt",descending: true),
        child: (datas,index){

          Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
          var book = BookModel.fromJson(json);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookListItem(
                book: book,
                onTap: (){
                  goto(context, BookDetailScreen(book: book,bookId: book.bookId,));
                },
                size: size,
              
              ),
              TextButton(onPressed: (){
                goto(context, PublishRewriteEditScreen(book: book));
              }, child: Text("Edit"))
            ],
          );
        });
  }
  Widget tab({required String text}){
    return Tab(

      child: Row(children: [
        Text(text),
        SizedBox(width: 4,),
        tabCount(context,
            // backgroundColor : selectedIndex == tabController. .indexOf(v)?colorRed:Colors.black87,

            future:  FirebaseFirestore.instance.collection("library").where("createdBy",isEqualTo: FirebaseAuth.instance.currentUser?.email ??"").where("status",isEqualTo: text).count().get())
      ],),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  TabBar(
          isScrollable: true,

            controller: tabController,
            labelColor: colorRed,
            indicatorColor: colorRed,
            onTap: (v){
              setState(() {
                selectedIndex = v;
              });
            },
            tabs: [
              // Tab(icon: Icon(Icons.download_done_sharp),),
          Tab(text: "New",),
              tab(text: Status.Drafted.name,),
              tab(text: Status.Private.name,),
              tab(text: Status.Review.name,),
              tab(text: Status.Publish.name),
              tab(text: Status.Rejected.name,),
        ]),
      ),
      body:
      TabBarView(
          controller: tabController,
          children: [
            // DownloadedIndexScreen(),
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

 Widget pod({required String title, required IconData icon, required  Function() onPressed,double size =14}) {
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
                    child: Image.asset("assets/book_cover.png",
                    height: 8*size,
                    width: 5*size,
                    )),
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
