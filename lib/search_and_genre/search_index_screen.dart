
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/tab_count.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../main.dart';
import '../models/genre_model.dart';

class SearchIndexScreen extends StatefulWidget {
  const SearchIndexScreen({super.key});

  @override
  State<SearchIndexScreen> createState() => _SearchIndexScreenState();
}

class _SearchIndexScreenState extends State<SearchIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;
int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController  = TabController(length: categories.length ,
        vsync: this);
  }
  @override

  Widget build(BuildContext context) {

    return NestedScrollView(
        headerSliverBuilder:(context,_)=> [
      ],
        body: Scaffold(
          backgroundColor: Colors.transparent,

      appBar:  AppBar(

                automaticallyImplyLeading: false,
                leadingWidth: 0,
                elevation:0,

                title:
          TabBar(
              isScrollable: true,
              controller: tabController,
              labelColor: colorRed,
              indicatorColor: colorRed,
              onTap: (v){
                setState(() {
                  selectedIndex = v;
                });
              },
              tabs: categories.map((v){
            return Tab(

                child:Row(
              children: [
                Text(v),
                SizedBox(width: 4,),
                tabCount(

                    context,
                    backgroundColor : selectedIndex == categories.indexOf(v)?colorRed:Colors.black87,
                    future: FirebaseFirestore.instance.collection("library").where("category",isEqualTo: v).where("private",isEqualTo: false).count().get())
              ],
            ) );
          }).toList())
              // SizedBox(height: 50,
              // child
              //     : ListView.  builder(
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context,index){
              //   return tabButton(
              //       isSelected:Provider.of<MainController>(context,listen: false).currentGenre==categories[index],
              //      fontWeight: FontWeight.w800,
              //       size: 17,
              //
              //       categories[index], onPressed: (){
              //     Provider.of<MainController>(context,listen: false,).currentGenre = categories[index];
              //     // goto(context,SearchIndexScreen());
              //   });
              // }),
              // )
      ),

            body:TabBarView(

                controller: tabController,
                children: categories.map((v){
            return  GenreIndexScreen(
              key: Key(v),
                  currentGenre:v
              );
            }).toList()),
          bottomNavigationBar: adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId4)

          ),
        ),
      );


  }
}
List<GenreModel> listOfGenre = [

];



