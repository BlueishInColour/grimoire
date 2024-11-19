import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_grid_item.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';

import '../../models/book_model.dart';
import '../views/load_widget.dart';

class BookGridAdapterItem extends StatefulWidget {
  const BookGridAdapterItem({super.key,this.onTap,required this.bookId,required this.size});
  final String bookId;
  final double size;
  final  dynamic Function()? onTap;
  @override
  State<BookGridAdapterItem> createState() => _BookGridAdapterItemState();
}

class _BookGridAdapterItemState extends State<BookGridAdapterItem> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("library").doc(widget.bookId).get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {return Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset("assets/book_cover.png",height: 16*widget.size,width: 9*widget.size,)),
              ],
            );}
            else if(snapshot.hasData&& snapshot.data?.data()?.isNotEmpty != null){
              BookModel book = BookModel.fromJson(snapshot.data?.data()??{});

              return BookGridItem(
                onTap:widget.onTap, book: book, id: book.bookId,imageUrl: book.bookCoverImageUrl,size: widget.size,);
            }
            else return Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset("assets/book_cover.png",height: 16*widget.size,)),
             Positioned(
                 bottom: 5,
                 left: 0,
                 right: 0,
                 child: Icon(Icons.error,color: Colors.white70,size: 12,))
              ],
            );
          }),
    );
  }
}
