import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grimoire/main_controller.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';

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
  //
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  // final PdfViewerController _pdfViewerController = PdfViewerController();

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
        // widget.isFile?
        // SfPdfViewer.file(File(widget.pdfPath),
        //   onTextSelectionChanged:
        //       (PdfTextSelectionChangedDetails details) {
        //     if (details.selectedText == null && _overlayEntry != null) {
        //       _overlayEntry!.remove();
        //       _overlayEntry = null;
        //     } else if (details.selectedText != null &&
        //         _overlayEntry == null) {
        //       _showContextMenu(context, details);
        //     }
        //   },
        //   // key: _pdfViewerKey,
        //   // controller: _pdfViewerController,
        // ):
        // SfPdfViewer.network(widget.pdfPath
        //
        //   )
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
      //     )
        widget.isFile?
            PdfViewer.file(widget.pdfPath)
            :PdfViewer.uri(Uri.parse(widget.pdfPath))
      ,  bottomNavigationBar: adaptiveAdsView(
          AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

      )
      ),
    );
  }
}

