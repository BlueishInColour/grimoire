import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/buttons/tag_button.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/read/pdf_viewer_screen.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:provider/provider.dart';
import '../../models/book_model.dart';
import '../buttons/download_button.dart';
import '../../home_books/book_detail_screen.dart';


class BookListItem extends StatefulWidget {
  const BookListItem({super.key,this.child,required this.onTap,
  required  this.book,
    this.tags =const [],
    this.genre ='',
    this.bookUrl = "",this.store = "",required this.imageUrl,required this.id,this.sold = 0,this.size=15,this.title = "",this.aboutBook="",this.authorPenName="grimoire",this.price = 20000});
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
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 10),
        child: SizedBox(
          //
          width: 400,


          child: GestureDetector(
            onLongPress: (){
    BookRepository().readBook(context, bookId: widget.id, bookPath: widget.bookUrl,isFile: false);
            },
            onTap: (){
              // c.readBook(context, bookId: widget.id, bookPath: widget.bookUrl,isFile: false);
              goto(context, BookDetailScreen(bookId:widget.id,book: widget.book,));

              },
            child: Container(
              width: 400,

              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)

              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,

                      // overflow: TextOverflow.ellipsis,

                    ),),
                  SizedBox(height: 10,),
                  SizedBox(
                    height:16*widget.size,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image(context,widget.imageUrl, widget.size),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(widget.aboutBook,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 12,
                              style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,


                              ),),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
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
      height: 16*size,
      width: 9*size,
      fit: BoxFit.fill,);
  }
  return  ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child:
    // kIsWeb?
        Container(
          color: Colors.grey[200],

          height: 16*size,
          width: 9*size,
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

            height: 16*size,
            width: 9*size,
          ),
        )
      //   : CachedNetworkImage(
      // imageUrl: imageUrl,
      // height: 16*size,
      // width: 9*size,
      // fit: BoxFit.fill,
      // placeholder: (_,__){
      //   return placeHolder();
      // },
      // errorWidget: (context,_,__){
      //   return placeHolder();
      // },
    
    // ),
  );
}
