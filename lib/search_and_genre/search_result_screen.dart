import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/book_model.dart';
import 'package:grimoire/commons/book_list_item.dart';
import 'package:grimoire/commons/paginated_view.dart';
import 'package:grimoire/main.dart';
import 'package:provider/provider.dart';

import '../main_controller.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key,this.searchText =""});

  final String searchText;
  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    String searchText = '';
    TextEditingController controller = TextEditingController();
    // String searchText = widget.searchText;

    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
            title: SizedBox(
              height: 40,
              child: TextField(
                controller: controller,
                onChanged: (v) {
                  setState(() {
                    searchText = v;
                  });
                },
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.grey[50]               ),
                autofocus: true,
                cursorHeight: 17,
                cursorColor:c.isLightMode? Colors.white:Colors.black,
                decoration: InputDecoration(
                    filled: true,
                    fillColor:c.isLightMode? Colors.black:Colors.white,
                 border: UnderlineInputBorder(
                   borderRadius: BorderRadius.circular(10),

                 ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      gotoReplace(context, SearchResultScreen(searchText: searchText,));
                    },
                    icon: Icon(Icons.search,
                    size: 18,
                    color: c.isLightMode?Colors.white:Colors.black,
                    ),
                  )

                ),
              ),
            )
        ),
        body: widget.searchText.isEmpty
            ? Center(child: Image.asset("assets/empty.png"),)
            : paginatedView(query: FirebaseFirestore.instance.collection('library').where(
            'searchTags',
            arrayContainsAny: widget.searchText.split(' ')) ,
            child: (json){
              BookModel book = BookModel.fromJson(json);
              return BookListItem(onTap: (){}, id: 0,
              title: book.title,
                aboutBook: book.aboutBook,
                bookUrl: book.bookUrl,
                imageUrl: book.bookCoverImageUrl,
                  authorPenName: book.authorPenName,
              );
            })

      ),
    );
  }
}
