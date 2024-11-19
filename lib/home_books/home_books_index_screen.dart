import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/home_books/read_list_pod.dart';
import 'package:grimoire/in_app_purchase/purchase_screen.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/list_model.dart';
import 'package:provider/provider.dart';

import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/paginated_view.dart';
import '../models/book_model.dart';

class HomeBooksIndexScreen extends StatefulWidget {
  const HomeBooksIndexScreen({super.key, this.actionBarChild});
final Widget? actionBarChild;
  @override
  State<HomeBooksIndexScreen> createState() => _HomeBooksIndexScreenState();
}

class _HomeBooksIndexScreenState extends State<HomeBooksIndexScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // showPremiumPurchaseScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
                backgroundColor: Colors.transparent,
                body: NestedScrollView(
                    headerSliverBuilder: (context, _) => [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: false,
                            snap: true,
                            floating: true,
                            forceMaterialTransparency: true,
                            title: TabBar(
                              controller: tabController,
                                isScrollable: true,
                                tabs: [Tab(text: "Recommended",),Tab(text: "My Picks",)]),
                            actions:[
                            Container(
                             // decoration: BoxDecoration(
                             //   borderRadius: BorderRadius.circular(30),
                             //   gradient:LinearGradient(
                             //       colors: [
                             //     Colors.purple.shade300,
                             //     Colors.purple.shade200,
                             //     Colors.purple.shade50,
                             //   ])
                             // ),
                             child: IconButton(onPressed: (){
                              showPremiumPurchaseScreen(context);
                             },
                             icon: Icon(EneftyIcons.magic_star_bold,
                             color: Colors.purple.shade900,),),
                           )
                            ]
                          ),


                        ],
                    body:TabBarView(
                        controller: tabController,
                        children: [
                      paginatedView(
                        key: Key("Recommended"),
                          query: FirebaseFirestore.instance.collection("list").where("status",isEqualTo: Status.Publish.name

                          ).orderBy("createdAt",descending: true).limit(20),
                          child: (datas,index){
                            Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
                            ListModel list = ListModel.fromJson(json);
                            return ReadListPod(list:list);
                          }),
                      paginatedView(
                          key: Key("My List"),

                          query: FirebaseFirestore.instance.collection("list").where("createdBy",isEqualTo:  FirebaseAuth.instance.currentUser?.email).orderBy("createdAt",descending: true).limit(20),
                          child: (datas,index){
                            Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
                            ListModel list = ListModel.fromJson(json);
                            return ReadListPod(list:list,showRecommendButton: true,);
                          })
                    ])
              ),
        bottomNavigationBar: adaptiveAdsView(
            AdHelper.getAdmobAdId(adsName:Ads.addUnitId3)

        ),


            ));
  }
}
