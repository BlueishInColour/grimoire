import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BookGridItem extends StatefulWidget {
  const BookGridItem({super.key,this.child,required this.onTap,this.store = "",this.imageUrl = "",required this.id,this.sold = 0,this.height=100,this.title = "",this.price = 20000});
  final double height;
  final int id;
  final String title;
  final double price;
  final int sold;
  final String imageUrl;
  final String store;
  final Function()? onTap;
  final Widget? child;

  @override
  State<BookGridItem> createState() => _BookGridItemState();
}

class _BookGridItemState extends State<BookGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: widget.height,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    // image:DecorationImage(
                    //     image:NetworkImage(widget.imageUrl)
                    // )

                ),
                child: Center(child: Icon(Icons.book,color:Colors.grey.shade600),),
              ),
              widget.sold==0?
              SizedBox.shrink()
                  :  Positioned(
                  bottom: 8,
                  left: 8
                  ,child: Row(
                children: [
                  Icon(Icons.star,
                    size: 12,
                    color: Colors.amber.shade800,),
                  SizedBox(width: 3,),
                  Text(widget.sold.toString(),
                    style: TextStyle(
                      color: Colors.amber.shade800,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,

                    ),
                  ),
                ],
              )),
              // Positioned(
              //     bottom: 8,
              //     right: 8
              //     ,child: Text(money(widget.price),
              //   style: TextStyle(
              //     color: APPCOLOR,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 10,
              //
              //     backgroundColor: Colors.blue.shade100,
              //     //
              //   ),
              // ))
            ],
          ),
          Text(widget.title,
            maxLines: 3,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 8,

              // overflow: TextOverflow.ellipsis,

            ),),
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
    );;
  }
}
