import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/load_widget.dart';

import '../../home_books/book_detail_screen.dart';
import '../../models/book_model.dart';

class ScreenAdapter extends StatelessWidget {
  const ScreenAdapter({super.key,required this.bookId});
  final String bookId;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("library").doc(bookId).get(),
        builder: (context,snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return loadWidget();
          }
          else if(snapshot.hasData){

            Map<String,dynamic> json = snapshot.data?.data() as Map<String,dynamic>;
            BookModel book = BookModel.fromJson(json);
            return BookDetailScreen(bookId: book.bookId, book: book);
          }
          else{
            return Image.asset("assets/empty");
          }
        });
  }
}
