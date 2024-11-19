import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';

import '../../home_books/book_detail_screen.dart';
import '../../main.dart';
import '../../models/book_model.dart';


class BookGridItem extends StatefulWidget {
  const BookGridItem({super.key,this.child,required this.onTap,
    this.tags =const [],
    required this.book,
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
  final Function()? onTap;
  final Widget? child;
  final List<String> tags;
  final BookModel book;

  @override
  State<BookGridItem> createState() => _BookGridItemState();
}

class _BookGridItemState extends State<BookGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: SizedBox(
        width: 9*widget.size,
        height: 16 *widget.size ,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image(context, widget.imageUrl, widget.size),
              // Text(widget.title,
              //   // maxLines: 2,
              //   style: GoogleFonts.merriweather(
              //     fontWeight: FontWeight.w400,
              //     fontSize: 10,
              //
              //     // overflow: TextOverflow.ellipsis,

                // ),
      // ),


            ],
          ),
        ),
      ),
    );;
  }
}
