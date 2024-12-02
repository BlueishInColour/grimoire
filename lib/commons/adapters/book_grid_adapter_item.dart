import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_grid_item.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/repository/like_repository.dart';

import '../../models/book_model.dart';
import '../views/load_widget.dart';

class BookGridAdapterItem extends StatefulWidget {
  const BookGridAdapterItem({super.key,required this.onTap,required this.bookId,required this.size});
  final String bookId;
  final double size;
  final  dynamic Function(BookModel) onTap;
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
                    child: image(context,"", widget.size)),
              ],
            );}
            else if(snapshot.hasData&& snapshot.data?.data()?.isNotEmpty != null){
              BookModel book = BookModel.fromJson(snapshot.data?.data()??{});

              if(book.status != Status.Publish) return Stack(
                children: [
                  image(
                    context,
                    book.bookCoverImageUrl,
                    MIDDLESIZE
                  ),
                  Positioned(
                    top: 5,left: 0,right: 0,
                    child: Center(child: Text("Un - published",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 10,
                      backgroundColor: Colors.white38,

                    ),)),
                  )
                ],
              );
              return BookGridItem(
                onDoubleTap: ()async{
                  showToast("Liked");
                  bool isLiked = await  LikeRepository().isLiked(book.bookId);
                  if(isLiked){
                   await LikeRepository().unLikeBook(book.bookId);
                  }
                  else{
                    await LikeRepository().likeBook(book.bookId);

                  }
                },
                onTap:()=>widget.onTap(book), book: book,size: MIDDLESIZE,);
            }
            else return Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: image(context,"",widget.size)),
             Text("un - available",
             style: GoogleFonts.montserrat(
               fontSize: 10,
               fontWeight: FontWeight.w700,
               color: Colors.grey.shade600
             ),)
             // Positioned(
             //     bottom: 5,
             //     left: 0,
             //     right: 0,
             //     child: Icon(Icons.error,color: Colors.white70,size: 12,))
              ],
            );
          }),
    );
  }
}
