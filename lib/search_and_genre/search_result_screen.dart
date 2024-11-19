import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/dictionary_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:provider/provider.dart';
import '../chat/chat_screen.dart';
import '../commons/views/book_grid_item.dart';
import '../commons/views/bottom.dart';
import '../commons/views/paginated_view.dart';
import '../main_controller.dart';
import '../models/book_model.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key,this.searchText ="Werewolf"});

  final String searchText;
  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with TickerProviderStateMixin{

  late TabController tabController;
  String searchText = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tabController = TabController(length:kDebugMode? 3:2, vsync: this);
    controller.text = widget.searchText;
    searchText = widget.searchText;
  }
  @override
  Widget build(BuildContext context) {
    // String searchText = widget.searchText;

    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
              controller: tabController,

              tabs: [
            Tab(text: "Books",),
                if(kDebugMode)    Tab(text: "Authors",),
            Tab(text: "Dictionary",),
          ]),
        ),

        body:  Column(
          children: [
            Expanded(
              child:
                TabBarView(
                    controller: tabController,
                    children: [
                  paginatedView(
                      query: FirebaseFirestore.instance.collection('library').where(
                          'searchTags',
                          arrayContainsAny: searchText.split(' ')) ,
                    emptyText: "No result for $searchText",
                      child: (datas,index){
                        List<BookModel> books = datas.map((v){return BookModel.fromJson(v.data() as Map<String,dynamic>);}).toList();
                        BookModel book  = books[index];
                        return BookListItem(

                            title: book.title,
                            aboutBook: book.aboutBook,
                            size: 10,onTap: (){},imageUrl: book.bookCoverImageUrl, book: book, id:book.bookId);
                      }),


                      if(kDebugMode)
                        paginatedView(
                      query: FirebaseFirestore.instance.collection('user').where(
                          'searchTags',
                          arrayContainsAny: widget.searchText.split(' ').map((v){if(v.length > 2) return v;}).toList()) ,
                      child: (datas,index){
                        List<BookModel> books = datas.map((v){return BookModel.fromJson(v.data() as Map<String,dynamic>);}).toList();
                        BookModel book  = books[index];
                        return BookListItem(onTap: (){},imageUrl: book.bookCoverImageUrl,


                            book: book, id:book.bookId);
                      }),
                  DictionaryView(
                    showSearchBar:false,
                    autoFocus: false,
                    searchText: searchText,
                  )
                ])
            ),
            BottomBar(
              child:(fontSize,iconSize)=> TextField(
                controller: controller,
                onChanged: (v){setState(() {
                  searchText = v;
                });},

                style: GoogleFonts.merriweather(
                    fontSize: fontSize,
                    color: Colors.white70
                ),


                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (v){
                  goto(context, SearchResultScreen(searchText: v,));
                },



                cursorHeight: 17,
                cursorColor: Colors.white,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    hintText: "search or ask the librarian ...",
                    hintStyle: GoogleFonts.merriweather(
                        fontSize: fontSize,
                        color: Colors.white70
                    ),
                    filled: true,

                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: (){
                            goto(context, MainApp());
                          },
                          icon: Icon(EneftyIcons.home_2_outline,size: iconSize,color: Colors.white70,)),
                    ),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: (){
                          goto(context, ChatScreen(email: "blueishincolour@gmail.com",
                            messageText:searchText,

                            showMessageBar: true,));

                        },
                        icon: Icon(searchText.isEmpty?Icons.chat_bubble_outline:Icons.send,
                          size: iconSize,
                          color: Colors.white70,
                        ),
                      ),
                    )

                ),
              ),
            ),
          ],
        ),


      ),
    );
  }
}
