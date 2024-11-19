import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/home_books/home_books_index_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/publish/my_books_index_screen.dart';
import 'package:grimoire/search_and_genre/search_index_screen.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // checkOrientation(context);
    });

  }
  @override
  Widget build(BuildContext context) {
    bool isTooSmallForTablet =MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide<500;
    return Scaffold(
     body:Row(
       children: [

         Expanded(
             flex: 5,
             child: HomeBooksIndexScreen(
               actionBarChild: Row(
                 children: [
                   IconButton(onPressed: (){
                     goto(context, MyBooksIndexScreen());
                   },
                       icon: Icon(EneftyIcons.edit_2_outline)),
                   IconButton(onPressed: (){
                     goto(context, AppIndexScreen());
                   },
                       icon: Icon(EneftyIcons.emoji_happy_outline)),
                 ],
               )
             )
         ),
         Expanded(
             flex: 4,
             child: SearchIndexScreen()),
        // isTooSmallForTablet? Expanded(
        //      flex: 1,
        //      child:
             SizedBox(
                 width: 100,
                 child: AppIndexScreen())
         // ):SizedBox.shrink(),
       ],
     )
    );
  }
}
