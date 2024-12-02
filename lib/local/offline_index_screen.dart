// import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/ads/ads_helper.dart';
import 'package:grimoire/commons/ads/ads_view.dart';
import 'package:grimoire/local/offline_book_grid_item.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/read/pdf_viewer_screen.dart';
import 'package:grimoire/repository/book_repository.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:path/path.dart' as path;
import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:provider/provider.dart';

import 'offline_book_list_item.dart';
class OfflineIndexScreen extends StatefulWidget {
  const OfflineIndexScreen({super.key,this.extension =""});
final String extension;
  @override
  State<OfflineIndexScreen> createState() => _OfflineIndexScreenState();
}

class _OfflineIndexScreenState extends State<OfflineIndexScreen> with TickerProviderStateMixin {
  List<String> files = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Provider.of<MainController>(context,listen: false).baseDirectory((directory){
       Provider.of<MainController>(context,listen: false).getFiles(directory, widget.extension, (v){
         setState(() {
           files.add(v);
         });
       });
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(

      builder:(context,c,child)=> Scaffold(

          body:
          files.isEmpty?
              Image.asset("assets/empty.png"):
          ListView.builder(
              itemCount: files.length,
              itemBuilder:(context,index){
            String filePath = files[index];

                  String fileName = path.basename(files[index]);
                  return OfflineBookListItem(
                    title:fileName,
                    size:6,
                    filePath:filePath,
                    onTap: (){BookRepository().readBook(context, bookId: "", bookPath: filePath,isFile: true);},
                  );
          }),
      bottomNavigationBar: adaptiveAdsView(AdHelper.getAdmobAdId(adsName: Ads.addUnitId5)),
      )

    );
  }
}


List<String> subSections = ["All","PDF","EPUB","DOC","PPT"];