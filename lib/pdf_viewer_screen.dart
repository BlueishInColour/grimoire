import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:grimoire/commons/ads_helper.dart';
import 'package:grimoire/commons/ads_view.dart';
import 'package:grimoire/main_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen({super.key,required this.pdfPath, required  this.pdfName ,this.isFile = false});
  final String pdfPath;
  final String pdfName;
  final bool isFile;

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  int totalPages = 0;
  int indexPages = 0;
  @override
  initState(){
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
          backgroundColor: c.isLightMode?Colors.white:Colors.black,
          foregroundColor: c.isLightMode?Colors.black:Colors.white,
          automaticallyImplyLeading: true,

          // actions: [
          //   Text("${indexPages.toString()}/${totalPages.toString()}",
          // ),
          //   SizedBox(width: 10,)
          // ],
        ),
      body:
        widget.isFile?SfPdfViewer.file(File(widget.pdfPath)):  SfPdfViewer.network(widget.pdfPath
            
          )
      // PDFView(
      //       onRender: (pages) => setState(() {
      //         totalPages = pages!;
      //       }),
      //       onPageChanged: (page, total) => setState(() {
      //         indexPages = page!;
      //       }),
      //       filePath: widget.pdfPath,
      //       pageFling: false,
      //       autoSpacing: false,
      //       enableSwipe: true,
      //       swipeHorizontal: true,
      //   nightMode:!c.isLightMode,
      //
      //
      //
      //     ),
        // bottomNavigationBar: AdsView(),
      ),
    );
  }
}

