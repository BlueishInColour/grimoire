import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/counts_text_view.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:numhelpers/numhelpers.dart';

import '../../home_books/book_detail_screen.dart';
import '../../main.dart';
import '../../models/book_model.dart';
import '../../search_and_genre/genre_search_index_screen.dart';


class BookGridItem extends StatefulWidget {
  const BookGridItem({super.key,this.child,required this.onTap,
    required this.book,
    required this.onDoubleTap,
    this.size=15});
  final double size;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Widget? child;
  final BookModel book;

  @override
  State<BookGridItem> createState() => _BookGridItemState();
}

class _BookGridItemState extends State<BookGridItem> {
  final style = GoogleFonts.montserrat(
    fontWeight: FontWeight.w800,
    fontSize: 10
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      child: SizedBox(
        width: 5 *widget.size,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image(context, widget.book.bookCoverImageUrl, widget.size),


              SizedBox(height: 4,),
              SizedBox(
                width: widget.size*5,
                height: 20,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: GestureDetector(
                          onTap:(){
                            // goto(context,GenreIndexScreen(currentGenre:widget.book.category));
                          },
                          child: Text(widget.book.category,
                            style: GoogleFonts.montserrat(
                                fontSize: 8,
                                fontWeight: FontWeight.w800
                            ),),
                        )),

                    widget.book.subCategory.isEmpty?
                        SizedBox(): Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                        width: 4,
                        height: 2,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children:
                      widget.book.subCategory.map((v){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: GestureDetector(

                                onTap: (){
                                  goto(context,
                                      Scaffold(
                                        appBar: AppBar(
                                          title: Text("Other Books From $v"),
                                        ),
                                        body: page(context, widget.book.category, v),
                                      ));
                                },
                                child: Text(v,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800
                                  ),),
                              )),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );;
  }
}
