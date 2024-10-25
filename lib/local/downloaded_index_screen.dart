import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/offline_book_grid_item.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/pdf_viewer_screen.dart';
import 'package:grimoire/search_and_genre/genre_index_screen.dart';
import 'package:path/path.dart' as path;
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:thumbnailer/thumbnailer.dart';

import '../commons/ads_view.dart';
class DownloadedIndexScreen extends StatefulWidget {
  const DownloadedIndexScreen({super.key});

  @override
  State<DownloadedIndexScreen> createState() => _DownloadedIndexScreenState();
}

class _DownloadedIndexScreenState extends State<DownloadedIndexScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(

      builder:(context,c,child)=> Scaffold(
        backgroundColor: Colors.transparent,

          body:Row(
            children: [
              Container(width: 100,
              child: ListView(
                children: [
                  ...subSections.map((v){
                    return sideButton(v,isSelected:  v =="All",onPressed: (){});
                  }).toList()
                ],
              ),),
              Expanded(
                child: ListView(
                  children: [
                    MasonryView(listOfItem: c.pdfDownloadedFiles,
                        numberOfColumn: 3,
                        itemBuilder: (v){
                          // String fileName = path.basename(c.pdfFiles[index]);
                          // String filePath = c.pdfFiles[index];
                
                          return OfflineBookGridItem(onTap: (){},
                          title: v,filePath: v,);
                        })
                  ],
                ),
              ),
            ],
          )
          // ListView.builder(
          //     itemCount: c.pdfFiles.length,
          //     itemBuilder: (context,index){
          //
          //       String fileName = path.basename(c.pdfFiles[index]);
          //       String filePath = c.pdfFiles[index];
          //
          //       return
          //         ListTile(
          //           titleAlignment: ListTileTitleAlignment.top,
          //           onTap: () async {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => PDFViewScreen(
          //                     pdfPath: filePath.toString(),
          //                     pdfName: fileName,
          //                   ),
          //                 ));
          //           },
          //           leading:
          //          SizedBox(
          //            height: 150,
          //            child: FutureBuilder(
          //              future: FilePreview.getThumbnail(filePath,defaultImage: Image.asset("assets/pdf_image.png")),
          //              builder: (context,snapshot) {
          //                if (snapshot.hasData) {
          //                  return snapshot.data ?? SizedBox();}
          //
          //                else return Image.asset("assets/pdf_image.png");
          //                }
          //            ),
          //          ),
          //           // Image. asset("assets/pdf_image.png"),
          //           title: Text(
          //             fileName,
          //             style: GoogleFonts.montserrat(
          //               fontSize: 12
          //                 // color: Colors.black
          //             ),
          //           ),
          //           // leading: PdfThumbnail.fromFile(
          //           //   height:150,
          //           //   filePath, currentPage: 1,)
          //         );}),
        // bottomNavigationBar:adaptiveAdsView()
      ),
    );
  }
}


List<String> subSections = ["A-Z","date","size","type",];