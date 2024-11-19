import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/counts_text_view.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:numhelpers/numhelpers.dart';

import '../../home_books/book_detail_screen.dart';
import '../../main.dart';
import '../../models/book_model.dart';


class BookGridItem extends StatefulWidget {
  const BookGridItem({super.key,this.child,required this.onTap,
    this.tags =const [],
    required this.book,
    required this.onDoubleTap,
    this.subCategories = const [],
    this.genre ='',
    this.bookUrl = "",this.store = "",this.imageUrl = "",required this.id,this.sold = 0,this.size=15,this.title = "",this.aboutBook="",this.authorPenName="grimoire",this.price = 20000});
  final double size;
  final String id;
  final String title;
  final String aboutBook;
  final String authorPenName;
  final double price;
  final int sold;
  final String imageUrl;
  final String bookUrl;
  final String store;
  final String genre;
  final List subCategories;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Widget? child;
  final List<String> tags;
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
              image(context, widget.imageUrl, widget.size),


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
                        child: Text(widget.book.category,
                          style: GoogleFonts.montserrat(
                              fontSize: 8,
                              fontWeight: FontWeight.w800
                          ),)),

                    widget.subCategories.isEmpty?
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
                      widget.subCategories.map((v){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(v,
                                style: GoogleFonts.montserrat(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800
                                ),)),
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
