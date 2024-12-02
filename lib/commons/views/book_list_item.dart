import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/buttons/tag_button.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/user.dart';
import 'package:grimoire/read/pdf_viewer_screen.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:grimoire/repository/user_repository.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:provider/provider.dart';
import '../../models/book_model.dart';
import '../buttons/download_button.dart';
import '../../home_books/book_detail_screen.dart';


class BookListItem extends StatefulWidget {
  const BookListItem({
    super.key,this.child,
    required this.onTap,
  required  this.book,
    required this.size,
    this.textColor = Colors.black87,
    this.secondTextColor = Colors.black54

  });
  final double size;
  final Widget? child;
  final BookModel book;
  final Function() onTap;
  final Color textColor;
  final Color secondTextColor;

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    BookModel book  = widget.book;
    return Consumer<MainController>(
      builder:(context,c,child)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 10),
        child: SizedBox(
          //
          width: 400,


          child: GestureDetector(
            onLongPress: (){
    BookRepository().readBook(context, bookId: book.bookId, bookPath: book.bookUrl,isFile: false);
            },
            onTap:widget.onTap,
            child: Container(

              child: SizedBox(
                height:8*widget.size,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image(context,book.bookCoverImageUrl, widget.size),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize:widget.size-5,
                                  color: widget.textColor
                                ),
                            ),
                          ),
                      
                          FutureBuilder(
                            future: UserRepository().getOneUser(email: widget.book.createdBy, isCompleted: (){}),
                            builder: (context, snapshot) {
                              final textStyle =  GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize:widget.size-10,
                                  color:widget.secondTextColor
                              );
                              if(snapshot.connectionState == ConnectionState.waiting) return Text("@",style: textStyle,);
                              else if(snapshot.hasData) {
                                User user = snapshot.data ??User();
                                  return Text("@" + user.full_name,
                                      style: textStyle);
                                }
                              else return Text("@curator",style: textStyle,);
                              }
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: book.tags.map((v){return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text("#" +v,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                color: widget.secondTextColor
                              ),),
                                                  
                            );}).toList(),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(Icons.book_outlined,color: Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(width: 2,),
                                FutureBuilder(
                                  future: FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: book.bookId).count().get(),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState==ConnectionState.waiting)return SizedBox();
                                    else if(snapshot.hasData) {
                                      int count = snapshot.data?.count??0;
                                          return Text(
                                            count.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                                color: widget.secondTextColor),
                                          );
                                        } else return SizedBox();
                                  }
                                ),],),
                              SizedBox(width: 10,),

                              Expanded(
                                child: SizedBox(
                                  // width: widget.size*5,
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
                                              // goto(context,GenreIndexScreen(currentGenre:book.category));
                                          },
                                            child: Text(widget.book.category,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                          )),
                                
                                      book.subCategory.isEmpty?
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
                                        book.subCategory.map((v){
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
                                                      body: page(context, book.category, v),
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
                              ),

                            ],
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}


Widget image(context,String imageUrl,double size,){
  Widget placeHolder(){
    return   Image.asset(
      "assets/book_cover.png",
      height: 8*size,
      width: 5*size,
      fit: BoxFit.fill,);
  }
  return  ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child:
    kIsWeb?
        Container(
          color: Colors.grey[200],

          height: 8*size,
          width: 5*size,
          child:imageUrl.isEmpty?
              placeHolder()

              : Image.network(
            imageUrl,
            errorBuilder: (context,_,__)=>placeHolder(),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return placeHolder();
            },
            fit: BoxFit.fill,

            height: 8*size,
            width: 5*size,
          ),
  )
        : CachedNetworkImage(
      imageUrl: imageUrl,
      height: 8*size,
      width: 5*size,
      fit: BoxFit.fill,

      errorWidget: (context,_,__){
        return placeHolder();
      },
    
    // ),
  ));
}
