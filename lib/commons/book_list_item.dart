import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/pdf_viewer_screen.dart';
import './download_button.dart';
import 'book_detail_screen.dart';


class BookListItem extends StatefulWidget {
  const BookListItem({super.key,this.child,required this.onTap,this.bookUrl = "",this.store = "",this.imageUrl = "",required this.id,this.sold = 0,this.height=150,this.title = "",this.aboutBook="",this.authorPenName="grimoire",this.price = 20000});
  final double height;
  final int id;
  final String title;
  final String aboutBook;
  final String authorPenName;
  final double price;
  final int sold;
  final String imageUrl;
  final String bookUrl;
  final String store;
  final Function()? onTap;
  final Widget? child;

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: (){goto(context, PDFViewScreen(pdfPath: widget.bookUrl, pdfName: widget.title));},
        onTap: (){goto(context, BookDetailScreen(bookId:"widget"));},
        child: Column(
          children: [
            Text(widget.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 14,

                // overflow: TextOverflow.ellipsis,

              ),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children:[
                    Container(
                      width: widget.height/1.50,
                      height: widget.height,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          image:DecorationImage(
                              fit: BoxFit.fill,
                              image:NetworkImage(widget.imageUrl)
                          )

                      ),
                      child:widget.imageUrl.isNotEmpty?SizedBox.shrink(): Center(child: Icon(Icons.book,color:Colors.grey.shade600),),
                    ),
                    Positioned(
                      bottom:1,
                      right:1,
                      child:DownloadButton(
                        bookUrl:widget.bookUrl,
                        title :widget.title
                      )
                    )
                  ]
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(widget.aboutBook,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,

                            // overflow: TextOverflow.ellipsis,

                          ),),
                        Text("by ${widget.authorPenName}",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ))
                      ],
                    ),
                  ),
                ),
                widget.child!=null?
                widget.child!
                    : Text(widget.store,
                  maxLines: 1,
                  style: TextStyle(
                    // color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,

                  ),),

              ],
            ),
          ],
        ),
      ),
    );;
  }
}
