
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/ads_mine_view.dart';
import 'package:grimoire/app/feedback_screen.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/management/categories_screen.dart';
import 'package:grimoire/management/news_screen.dart';
import 'package:grimoire/management/review_books_screen.dart';
import 'package:grimoire/management/review_lists_screen.dart';
import 'package:grimoire/management/users_screen.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../main.dart';
import '../models/genre_model.dart';

class ManagementIndexScreen extends StatefulWidget {
  const ManagementIndexScreen({super.key});

  @override
  State<ManagementIndexScreen> createState() => _ManagementIndexScreenState();
}

class _ManagementIndexScreenState extends State<ManagementIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController  = TabController(length: managementTabs.length ,
        vsync: this,initialIndex: 1);
  }
  @override

  Widget build(BuildContext context) {

    return NestedScrollView(
      headerSliverBuilder:(context,_)=> [
      ],
      body: Scaffold(
        backgroundColor: Colors.transparent,

        appBar:  AppBar(

          backgroundColor: Colors.white,
            automaticallyImplyLeading: true,

            title:
            TabBar(
                isScrollable: true,
                controller: tabController,
                tabs: managementTabs.map((v){
                  return Tab(text: v);
                }).toList())

        ),

        body:TabBarView(
            controller: tabController,
            children: [
              AdsMineView(),
              UsersScreen(),
              NewsScreen(),
              ReviewBooksScreen(),
              ReviewListsScreen(),
              // Text("Review Stories"),
              CategoriesScreen(),
              // Text("Privacy"),
              // Text("Terms of service"),
            ]),
        bottomNavigationBar: adaptiveAdsView(
            AdHelper.getAdmobAdId(adsName:Ads.addUnitId4)

        ),
      ),
    );


  }
}
List<String> managementTabs = [
  "Ads Mine",
  "Users",
  "News",
  "Review Books",
  "Review Lists",
  // "Review Stories",
  "Categories",
  // "Privacy Policy",
  // "Terms Of Service"




];


bool isManagement = FirebaseAuth.instance.currentUser?.email == "blueishincolour@gmail.com" || FirebaseAuth.instance.currentUser?.email == "amooisiah942@gmail.com" ;


