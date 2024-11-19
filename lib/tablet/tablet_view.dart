import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/ads_mine_view.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/app/history_index_screen.dart';
import 'package:grimoire/home_books/home_books_index_screen.dart';
import 'package:grimoire/local/downloaded_index_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/management/management_index_screen.dart';
import 'package:grimoire/publish/my_books_index_screen.dart';
import 'package:grimoire/search_and_genre/search_index_screen.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import 'package:grimoire/tablet/tablet_ui_controller.dart';
import 'package:provider/provider.dart';

import '../auth/log_out_dialog.dart';
import '../home_books/book_detail_screen.dart';
import '../main_controller.dart';
import '../commons/views/not_for_web.dart';

class TabletView extends StatefulWidget {
  const TabletView({super.key});

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
checkOrientation(context){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if(isPortrait){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Rotate phone to landscape for a better view")));
    }
  }
Widget listTile(tab v){
  return IconButton(
    onPressed:v.onTap,
    icon: Icon(v.icon,
      color: Colors.white,
      size: 14,
      opticalSize: 100,
        fill: 1,
        weight: 100,


    ),
    // trailing:  v.child != null?v.child!: Icon(Icons.arrow_forward_ios_rounded,size: 10,)
  );
}

Widget listTileColumn(List<tab> listOfTab){
  return     Consumer<MainController>(
    builder:(context,c,child)=> Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:Colors.white24
        ),
        child: Column(children: listOfTab.map((v){
          return listTile(v);
        }).toList(),),
      ),
    ),
  );

}
checkConectivity()async{

  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    ggoto(context, 5);
    ggoto(context, 5,1);
    showToast("No Internet Connection");
  }

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // checkOrientation(context);
      checkConectivity();

    });

  }
  @override
  Widget build(BuildContext context) {
    bool isTooSmallForTablet =MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide<500;
    return Consumer<TabletUIController>(
      builder:(context,c,child)=> Scaffold(
       body:Row(
         children: [
           SizedBox(
               width: 80,
               child: Image.asset(
                 height: MediaQuery.of(context).size.height,
                   fit: BoxFit.cover,
                   "assets/book_cover.png").blurred(
                 blur: 10,
                 blurColor: Colors.black45,
      overlay: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
            SizedBox(height: 10,),
            CircleAvatar(
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser?.photoURL??""
              ),
            ),

            listTileColumn(
                [
              tab(title: "Home", onTap: (){
                ggoto(context, 0);
                ggoto(context, 0,1);
              },
              icon: EneftyIcons.home_2_outline)
            ]),
            listTileColumn(listOfInApp(context,isTablet: true)),
            notForWeb(child: listTileColumn(listOfGoogleTabs(context))),
            listTileColumn(listOfApp(context)),
            SizedBox(height: 50,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Center(
                child: TextButton(onPressed: (){
                  showDialog(context: context, builder: (context){
                    return logoutDialog(context);
                  });
                }, child: Center(
                  child: Text("Log Out",
                    style: GoogleFonts.montserrat(
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.w900
                    ),),
                )),
              )
            ],),
            SizedBox(height: 250,)

              ],
            ),
          ),
          listTileColumn(
              [
                tab(title: "Expanded", onTap: (){
                  ggoto(context, 5,1);
                },
                    icon: Icons.arrow_forward_ios)
              ]),
        ],
      )
               )),
           Expanded(
               flex: 5,
               child:
               [
                 HomeBooksIndexScreen(isTablet: true,),
                 HistoryIndexScreen(),
                 MyBooksIndexScreen(),
                 SearchResultScreen(),
                 SizedBox(),
                 DownloadedIndexScreen()
               ][c.mainSelectedIndex]
           ),
           Divider(
             color: Colors.black,
             thickness: 4,
           ),
           Expanded(
               flex: 4,
               child:[
                 SearchIndexScreen(),
                 ManagementIndexScreen(),
                 AdsMineView(),
                 SizedBox(),
                 SearchResultScreen(),
                 AppIndexScreen()


               ][c.secondSelectedIndex]),
          // isTooSmallForTablet? Expanded(
          //      flex: 1,
          //      child:

           // ):SizedBox.shrink(),
         ],
       )
      ),
    );
  }
}

ggoto(context,index,[screen = 0]){
if(screen==0) {
  Provider
      .of<TabletUIController>(context,listen: false)
      .mainSelectedIndex = index;
}
else {
  Provider.of<TabletUIController>(context,listen: false).secondSelectedIndex = index;

}
}