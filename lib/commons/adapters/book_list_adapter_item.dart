import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';

import '../../models/book_model.dart';

class BookListAdapterItem extends StatefulWidget {
  const BookListAdapterItem({super.key,this.showDate = true,required this.createdAt,required this.bookId,required this.size});
final String bookId;
final DateTime createdAt;
final double size;
final bool showDate;
  @override
  State<BookListAdapterItem> createState() => _BookListAdapterItemState();
}

class _BookListAdapterItemState extends State<BookListAdapterItem> {
  String getDayNumber(){

    DateTime date =widget.createdAt;
    return date.format("D");
  }
  String getDay(){
    DateTime date = widget.createdAt;
   return date.format("dS");
  }

  String getMonth(){

    DateTime date =widget.createdAt;
    return date.format("M");
  }
  String getYear(){

    DateTime date = widget.createdAt;
    return"'${ date.format("y")}";
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: FirebaseFirestore.instance.collection("library").doc(widget.bookId).get(),
    builder: (context, snapshot) {
    if(snapshot.connectionState==ConnectionState.waiting)
      {return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
        flex: 1,
              child: Container(
                width:80,

              ),
            ),
            Expanded(
              flex:3,
              child: Container(
                padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                height :16*widget.size,
                  child: Row(
                    children: [
                      Container(
                        color: Colors.grey[100],
                        height :16*widget.size,
                        width: 9*widget.size,
                      )
                    ],
                  ),
              ),
            ),
          ],
        ),
      );}
    else if(snapshot.hasData && snapshot.data?.data()?.isNotEmpty != null){
      BookModel book = BookModel.fromJson(snapshot.data?.data()??{});

      return Row(
        children: [
         widget.showDate? SizedBox(
            height :16*widget.size,
            width: 80,child: Column
            (
            mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(getDayNumber(),
                style: GoogleFonts.merriweather(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 12
                ),
                ),
                Text(getDay(),
                  style: GoogleFonts.merriweather(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                  ),
                ),
                Text(getMonth(),
                  style: GoogleFonts.merriweather(
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      fontSize: 28
                  ),
                ),
                Text(getYear(),
                  style: GoogleFonts.merriweather(
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      fontSize: 15
                  ),
                ),
                ],
                ),):SizedBox.shrink(),
          BookListItem(
            book: book,
              onTap: (){
                goto(context, BookDetailScreen(book:book,bookId: widget.bookId,));
              },
              id: widget.bookId,
          aboutBook: book.aboutBook,
              bookUrl: book.bookUrl,
              imageUrl: book.bookCoverImageUrl,
              genre: book.category,
              size: widget.size,
          title: book.title,),
        ],
      );
    }
    else return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Expanded(
            flex: 1,
            child: Container(
                width:80,

              ),
          ),
            Expanded(
              flex:3,
              child: Container(
                padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                height :16*widget.size,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/book_cover.png",
                      height :16*widget.size,
                      width: 9*widget.size,
                    ),

                    SizedBox(width: 10,),
                    Text("This Book is Unavailable.",
                    style: GoogleFonts.merriweather(),)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
        });
  }
}
