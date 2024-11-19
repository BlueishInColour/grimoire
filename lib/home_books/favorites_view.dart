import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/book_grid_adapter_item.dart';
import 'package:grimoire/commons/adapters/book_list_adapter_item.dart';
import 'package:grimoire/commons/buttons/like_button.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/home_books/read_list_pod.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/history_model.dart';
import 'package:grimoire/repository/like_repository.dart';

import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../constant/CONSTANT.dart';
import '../models/book_model.dart';
import '../models/list_model.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite,color: colorRed,),
                SizedBox(width: 5,),
                Text("Favorites",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    color: colorRed

                ),),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
      body:paginatedView(

        loadWidgetColor: colorRed,

          query: LikeRepository().ref
              .orderBy("createdAt", descending: true),
          child: (datas, index) {
            Map<String, dynamic> json = datas[index].data() as Map<
                String,
                dynamic>;
            HistoryModel history = HistoryModel.fromJson(json);
            return BookListAdapterItem(
              isDarkMode: true,
              showDate: true,
              child:(v)=> LikeButton(bookId: history.bookId),

              createdAt: history.createdAt,
                onTap: (book){
                  goto(context, BookDetailScreen(bookId: book.bookId, book: book));
                },
                bookId: history.bookId,
                size: 25);})
    );



  }
}
