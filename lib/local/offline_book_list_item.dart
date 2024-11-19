import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

              height:16*widget.size,
              width: 9*widget.size,
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            // height: 150,
            child: FutureBuilder(
            future: FilePreview.generatePDFPreview(

                widget.filePath,
                height:16*widget.size,
                width: 9*widget.size,


                defaultImage: Image.asset("assets/book_cover.png",fit: BoxFit.fill,)
            ),
            builder: (context,snapshot) {
            if (snapshot.hasData) {
            return snapshot.data ?? SizedBox();}

            else return  Image.asset("assets/book_cover.png");
            }
            ),
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
