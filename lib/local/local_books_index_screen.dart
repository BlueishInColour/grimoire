import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/local/offline_index_screen.dart';
import 'package:grimoire/main_controller.dart';
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
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: TabBar(
              controller: tabController,
              isScrollable: true,
              labelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w900,
                  fontSize: 12
              ),
              unselectedLabelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: 12
              ),
              padding: EdgeInsets.symmetric(horizontal: 0),

              labelColor:c.isLightMode?Colors.black: Colors.white,
              tabAlignment: TabAlignment.center,

              unselectedLabelColor:c.isLightMode?Colors.black54: Colors.white54,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor:c.isLightMode?Colors.black: Colors.white,
              indicatorWeight: 0.8,
              dividerColor: Colors.transparent,

              tabs: [
                Tab(child: Text("Downloaded"),),

                Tab(child: Text("Local")),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              DownloadedIndexScreen(),
              OfflineIndexScreen(

              )
            ],
          ),
        ),
      ),
    );
  }
}


