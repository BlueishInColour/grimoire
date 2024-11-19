import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';

import '../../models/book_model.dart';

class BookListAdapterItem extends StatefulWidget {
  const BookListAdapterItem({super.key,required this.onTap,this.child,this.showDate = true,required this.createdAt,this.isDarkMode =false,required this.bookId,required this.size});
final String bookId;
final DateTime createdAt;
final double size;
final bool showDate;
final bool isDarkMode;
 final Function(BookModel)? onTap;
 final Widget Function(BookModel)?  child;
  @override
  State<BookListAdapterItem> createState() => _BookListAdapterItemState();
}

class _BookListAdapterItemState extends State<BookListAdapterItem> {
  String getDay(){

    DateTime date =widget.createdAt;
    return date.format("D");
  }
  String getDayNumber(){
    DateTime date = widget.createdAt;
   return date.format("jS");
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
    bool isDarkMode = widget.isDarkMode;
    return  FutureBuilder(
        future: FirebaseFirestore.instance.collection("library").doc(widget.bookId).get(),
    builder: (context, snapshot) {
    if(snapshot.connectionState==ConnectionState.waiting)
      {return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 8*widget.size,
          child: Row(
            children: [
              Container(
                width:60,

              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height :8*widget.size,
                    child: Row(
                      children: [
                       image(context, "imageUrl", MIDDLESIZE)
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
      );}
    else if(snapshot.hasData && snapshot.data?.data()?.isNotEmpty != null && snapshot.data!.exists  && snapshot.data!.data()!.isNotEmpty ??false){
      BookModel book = BookModel.fromJson(snapshot.data?.data()??{});

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 8*widget.size,

          child: Row(
            children: [
             widget.showDate? SizedBox(
                width: 60,child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column
                    (
                    mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        Text(getDay(),
                          style: GoogleFonts.merriweather(
                              color:isDarkMode?Colors.white60: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 8
                          ),
                        ),
                          Text(getDayNumber(),
                            style: GoogleFonts.merriweather(
                                color: isDarkMode?Colors.white60:Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            ),
                          ),
                        Text(getMonth(),
                          style: GoogleFonts.merriweather(
                              color:isDarkMode?Colors.white60: Colors.black54,
                              fontWeight: FontWeight.w900,
                              fontSize: 23
                          ),
                        ),
                        Text(getYear(),
                          style: GoogleFonts.merriweather(
                              color:isDarkMode?Colors.white60: Colors.black54,
                              fontWeight: FontWeight.w900,
                              fontSize: 10
                          ),
                        ),
                        ],
                        ),
                  widget.child !=null? widget.child!(book):SizedBox()
                  ],
                ),):SizedBox.shrink(),
              Expanded(
                child: BookListItem(
                  book: book,
                    textColor:Colors.white,
                    secondTextColor: Colors.white60,
                    onTap:()=> widget.onTap!(book),

                    size: widget.size,
               ),
              ),
            ],
          ),
        ),
      );
    }
    else return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Container(
              width:60,
            ),
            Expanded(
              child: Container(

                height :8*widget.size,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image(context, "imageUrl", MIDDLESIZE),

                    SizedBox(width: 10,),
                    Text("This Book is Unavailable.",
                    style: GoogleFonts.merriweather(
                      color: isDarkMode?Colors.white:Colors.black87
                    ),)
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

