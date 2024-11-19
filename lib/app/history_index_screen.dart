import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/adapters/book_list_adapter_item.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/repository/history_repository.dart';
import 'package:line_icons/line_icons.dart';

import '../commons/views/paginated_view.dart';
import '../home_books/book_detail_screen.dart';
import '../main.dart';
import '../models/history_model.dart';

class HistoryIndexScreen extends StatefulWidget {
  const HistoryIndexScreen({super.key});

  @override
  State<HistoryIndexScreen> createState() => _HistoryIndexScreenState();
}

class _HistoryIndexScreenState extends State<HistoryIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: colorPurple,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history,color: colorPurple,),
            SizedBox(width: 5,),
            Text("history",
            style: GoogleFonts.montserrat(
              color: colorPurple,
              fontWeight: FontWeight.w800
            ),),
          ],
        ),
      ),
       body:
       paginatedView(query:
       HistoryRepository().ref.orderBy("createdAt",descending: true),
           child: (datas,index) {
             Map<String, dynamic> json = datas[index].data() as Map<
                 String,
                 dynamic>;
             HistoryModel historyModel = HistoryModel.fromJson(json);
             DateTime dateTime = DateTime.parse(json["createdAt"]);


             return BookListAdapterItem(
               isDarkMode: true,
                 showDate: true,
               bookId: json["bookId"], size: MIDDLESIZE,createdAt:historyModel.createdAt, onTap: (book ) {
               goto(context, BookDetailScreen(book:book,bookId: book.bookId,));

             },);
           }
           )
    );
  }
}
