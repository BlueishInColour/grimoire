import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/pdf_viewer_screen.dart';
import 'package:pdf_thumbnail/pdf_thumbnail.dart';


class OfflineBookGridItem extends StatefulWidget {
  const OfflineBookGridItem({super.key,required this.onTap,this.filePath = "",this.height=100,this.title = "",});
  final double height;
  final String title;
  final String filePath;
  final Function()? onTap;

  @override
  State<OfflineBookGridItem> createState() => _OfflineBookGridItemState();
}

class _OfflineBookGridItemState extends State<OfflineBookGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){goto(context, PDFViewScreen(pdfPath: widget.filePath, pdfName: widget.filePath,isFile: true,));},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                // height: widget.height,
                decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    // image:DecorationImage(
                    //     image:NetworkImage(widget.imageUrl)
                    // )


                ),
                child:
                SizedBox(
                  // height: 150,
                             child: FutureBuilder(
                               future: FilePreview.getThumbnail(

                                   widget.filePath,
    defaultImage: Image.asset("assets/pdf_image.png")),
                               builder: (context,snapshot) {
                                 if (snapshot.hasData) {
                                   return snapshot.data ?? SizedBox();}

                                 else return Image.asset("assets/pdf_image.png");
                                 }
                             ),
                           ),
                            // Image. asset("assets/pdf_image.png"),
                            // title: Text(
                            //   fileName,
                            //   style: GoogleFonts.montserrat(
                            //     fontSize: 12
                                  // color: Colors.black
                              // ),
                            // ),
                            // leading: PdfThumbnail.fromFile(
                            //   height:150,
                            //   filePath, currentPage: 1,)
                          // );}),
              ),
            ],
          ),
          Text(widget.title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 8,
              // overflow: TextOverflow.ellipsis,

            ),),
          // Text(widget.store,
          //   style: TextStyle(
          //     color: Colors.black45,
          //     fontWeight: FontWeight.w400,
          //     fontSize: 10,
          //     overflow: TextOverflow.ellipsis,
          //
          //   ),),

        ],
      ),
    );;
  }
}
