import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/app/history_index_screen.dart';
import 'package:grimoire/commons/views/tab_count.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/home_books/favorites_view.dart';
import 'package:grimoire/home_books/read_list_pod.dart';
import 'package:grimoire/in_app_purchase/purchase_screen.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/models/follow_model.dart';
import 'package:grimoire/models/list_model.dart';
import 'package:grimoire/publish/coming_soon_screen.dart';
import 'package:grimoire/repository/coming_soon_repository.dart';
import 'package:grimoire/repository/follow_repository.dart';
import 'package:grimoire/repository/like_repository.dart';
import 'package:grimoire/tablet/tablet_ui_controller.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../main.dart';
import '../models/book_model.dart';
import '../news/news_letter_widget.dart';
import '../search_and_genre/search_result_screen.dart';
import 'package:intl/locale.dart';

class HomeBooksIndexScreen extends StatefulWidget {
  const HomeBooksIndexScreen(
      {super.key, this.isTablet = false, this.actionBarChild});
  final Widget? actionBarChild;
  final bool isTablet;
  @override
  State<HomeBooksIndexScreen> createState() => _HomeBooksIndexScreenState();
}

class _HomeBooksIndexScreenState extends State<HomeBooksIndexScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final controller = TextEditingController();

  String searchText = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 2);
    // showPremiumPurchaseScreen(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // checkOrientation(context);
      if (Provider.of<MainController>(context, listen: false).openHomeCount ==
          0)
        showModalBottomSheet(
            context: context,
            builder: (context) {
              var randomScreen = [
                ComingSoonScreen(),
                FavoritesView(),
                HistoryIndexScreen(),
              ];
              randomScreen.shuffle();
              Provider.of<MainController>(context, listen: false)
                  .openHomeCount = 1;
              return randomScreen[0];
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
        builder: (context, c, child) => Scaffold(
              backgroundColor: Colors.transparent,
              body: NestedScrollView(
                  headerSliverBuilder: (context, _) => [
                        SliverAppBar(
                          pinned: false,
                          title: Text(
                            AppLocalizations.of(context)!.app_name,
                            style: GoogleFonts.pacifico(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          bottom: AppBar(
                              title: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: WidgetStatePropertyAll(0),
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.grey.shade100),
                                        fixedSize: WidgetStatePropertyAll(Size(
                                            MediaQuery.of(context).size.width,
                                            55)),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30)))),
                                    onPressed: () {
                                      if (!widget.isTablet) {
                                        goto(context, SearchResultScreen());
                                      } else {
                                        Provider.of<TabletUIController>(context,
                                                listen: false)
                                            .mainSelectedIndex = 3;
                                        Provider.of<TabletUIController>(context,
                                                listen: false)
                                            .secondSelectedIndex = 3;
                                      }
                                    },
                                    child: Container(
                                        // padding: EdgeInsets.all(10),
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "search or chat librarian",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            showToast("Opening whatsapp");
                                            await EasyLauncher.sendToWhatsApp(
                                                phone: librarianNumber,
                                                message: "Hi");
                                          },
                                          icon: LineIcon.whatSApp(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ))),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        barrierColor: colorPurple,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  150,
                                              child: HistoryIndexScreen());
                                        });
                                  },
                                  icon: Icon(
                                    Icons.history,
                                    color: Colors.grey.shade700,
                                  ))
                            ],
                          )),
                        ),
                        SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: true,
                            snap: true,
                            floating: true,
                            centerTitle: true,
                            forceMaterialTransparency: true,
                            leading: IconButton(
                              onPressed: () {
                                // showPremiumPurchaseScreen(context);

                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    barrierColor: colorRed,
                                    builder: (context) {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150,
                                          child: FavoritesView());
                                    });
                              },
                              icon: Badge(
                                backgroundColor: Colors.transparent,
                                label: tabCount(context,
                                    future:
                                        LikeRepository().totalCountsOfLikes()),
                                child: Icon(
                                  EneftyIcons.heart_bold,
                                  color: colorRed,
                                ),
                              ),
                            ),
                            title: TabBar(
                                controller: tabController,
                                isScrollable: true,
                                tabAlignment: TabAlignment.center,
                                tabs: [
                                  Tab(
                                    text: "Mine",
                                  ),
                                  Tab(
                                    text: "Following",
                                  ),
                                  Tab(
                                    text: "Recommended",
                                  ),
                                ]),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        barrierColor: colorBlue,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  150,
                                              child: ComingSoonScreen());
                                        });
                                  },
                                  icon: Badge(
                                    backgroundColor: Colors.transparent,
                                    label: tabCount(context,
                                        future: ComingSoonRepository()
                                            .totalCountsOfSchedules()),
                                    child: Icon(
                                      Icons.offline_bolt_rounded,
                                      color: colorBlue,
                                    ),
                                  )),
                            ],
                            bottom: kDebugMode
                                ? AppBar(
                                    automaticallyImplyLeading: false,
                                    title: NewsLetterWidget(),
                                    toolbarHeight: 20,
                                  )
                                : null),
                      ],
                  body: TabBarView(controller: tabController, children: [
                    paginatedView(
                        key: Key("Mine"),
                        query: FirebaseFirestore.instance
                            .collection("list")
                            .where("createdBy",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser?.email ??
                                        "")
                            .orderBy("createdAt", descending: true)
                            .limit(20),
                        child: (datas, index) {
                          Map<String, dynamic> json =
                              datas[index].data() as Map<String, dynamic>;
                          ListModel list = ListModel.fromJson(json);
                          return ReadListPod(list: list);
                        }),
                    FollowingRecommendationView(),
                    paginatedView(
                        key: Key("Recommended"),
                        query: FirebaseFirestore.instance
                            .collection("list")
                            .where("status", isEqualTo: Status.Publish.name)
                            .orderBy("createdAt", descending: true)
                            .limit(20),
                        child: (datas, index) {
                          Map<String, dynamic> json =
                              datas[index].data() as Map<String, dynamic>;
                          ListModel list = ListModel.fromJson(json);
                          return ReadListPod(list: list);
                        }),
                  ])),
              bottomNavigationBar: adaptiveAdsView(
                  AdHelper.getAdmobAdId(adsName: Ads.addUnitId3)),
            ));
  }
}

// import 'package:flutter/material.dart';

class FollowingRecommendationView extends StatefulWidget {
  const FollowingRecommendationView({super.key});

  @override
  State<FollowingRecommendationView> createState() =>
      _FollowingRecommendationViewState();
}

class _FollowingRecommendationViewState
    extends State<FollowingRecommendationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: paginatedView(
            query: FollowRepository().ref,
            child: (datas, index) {
              FollowModel followModel = FollowModel.fromJson(
                  datas[index].data() as Map<String, dynamic>);
              return paginatedView(
                  shrinkWrap: true,
                  key: Key("My List"),
                  query: FirebaseFirestore.instance
                      .collection("list")
                      .where("createdBy", isEqualTo: followModel.followedAt)
                      .where("status", isEqualTo: Status.Publish.name)
                      .orderBy("createdAt", descending: true)
                      .limit(20),
                  child: (datas, index) {
                    Map<String, dynamic> json =
                        datas[index].data() as Map<String, dynamic>;
                    ListModel list = ListModel.fromJson(json);
                    return ReadListPod(
                      list: list,
                      showRecommendButton: true,
                    );
                  });
            }));
  }
}
