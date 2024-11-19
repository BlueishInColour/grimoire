import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/main_controller.dart';
import 'package:provider/provider.dart';

import '../../models/book_model.dart';

class BookRankView extends StatefulWidget {
  const BookRankView({super.key,required this.books,this.size = 13});
final List<BookModel> books;
final double size;
  @override
  State<BookRankView> createState() => _BookRankViewState();
}

class _BookRankViewState extends State<BookRankView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Container(
          height: 16*widget.size,


          child: ListView.builder(
            itemCount: widget.books.length,


          scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
            return image(context,widget.books[index].bookCoverImageUrl, widget.size);
            },
          
        )
      ),
    );
  }
}
