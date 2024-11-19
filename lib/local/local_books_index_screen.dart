import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/in_app_purchase/purchase_screen.dart';
import 'package:grimoire/local/offline_index_screen.dart';
import 'package:grimoire/main_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'downloaded_index_screen.dart';

class LocalBooksIndexScreen extends StatefulWidget {
  const LocalBooksIndexScreen({super.key});

  @override
  State<LocalBooksIndexScreen> createState() => _LocalBooksIndexScreenState();
}

class _LocalBooksIndexScreenState extends State<LocalBooksIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 6, vsync: this,initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(

              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.2, 0.5],
              colors: [
                Colors.purple.shade50,
                Colors.blue.shade50,
                Colors.grey.shade50,

              ]
          ),

        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            title: TabBar(
              controller: tabController,
              // isScrollable: true,
             isScrollable: true,
              tabs: [
                Tab(child: Text("Downloaded"),),
                Tab(child: Text("PDF")),
                Tab(child: Text("EPUB")),
                Tab(child: Text("DOC")),
                Tab(child: Text("DOCx")),
                Tab(child: Text("PPT")),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              // PurchaseScreen(),
              DownloadedIndexScreen(),
              OfflineIndexScreen(key:Key("pdf"),extension:"pdf"),
              OfflineIndexScreen(key:Key("epub"),extension:"epub"),
          OfflineIndexScreen(key:Key("doc"),extension:"doc"),
          OfflineIndexScreen(key:Key("docx"),extension:"docx"),
              OfflineIndexScreen(key:Key("ppt"),extension:"ppt"),

            ],
          ),
        ),
      ),
    );
  }
}
