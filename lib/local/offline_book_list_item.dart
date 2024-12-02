// import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/constant/CONSTANT.dart';

class OfflineBookListItem extends StatefulWidget {
  const OfflineBookListItem({super.key,required this.onTap,this.filePath = "",this.size=100,this.title = "",});
  final double size;
  final String title;
  final String filePath;
  final Function()? onTap;

  @override
  State<OfflineBookListItem> createState() => _OfflineBookListItemState();
}

class _OfflineBookListItemState extends State<OfflineBookListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 400,
          height: 16*widget.size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(

              height:16*SMALLSIZE,
              width: 9*SMALLSIZE,
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            // height: 150,
            child: Image.asset("assets/book_cover.png",fit: BoxFit.fill,)
            ),
          ),
              SizedBox(width: 10,),
              Expanded(child: Text(widget.title,style: GoogleFonts.merriweather(

              ),))
            ],
          ),
        ),
      ),
    );
  }
}
