import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:grimoire/app/privacy-policy.dart';
import 'package:grimoire/app/terms_of_service.dart';
import 'package:grimoire/auth/auth_gate.dart';
import 'package:grimoire/auth/controller/create_user_controller.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/first_timer_screen.dart';
import 'package:grimoire/local/downloaded_index_screen.dart';
import 'package:grimoire/publish/creator_index_screen.dart';
import 'package:grimoire/search_and_genre/genre_search_index_screen.dart';
import 'package:grimoire/tablet/tablet_auth_view.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/home_books/home_books_index_screen.dart';
import 'package:grimoire/in_app_purchase/in_app_purchase_controller.dart';
import 'package:grimoire/local/local_books_controller.dart';
import 'package:grimoire/local/local_books_index_screen.dart';
import 'package:grimoire/local/offline_index_screen.dart';
import 'package:grimoire/publish/my_books_index_screen.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/read/story_viewer_ui_controller.dart';
import 'package:grimoire/search_and_genre/search_index_screen.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import 'package:grimoire/management/management_index_screen.dart';
import 'package:grimoire/tablet/tablet_ui_controller.dart';
import 'package:grimoire/tablet/tablet_view.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'commons/ads/app_open_ads_manager.dart';
import 'read/markdown_screen.dart';
import 'constant/CONSTANT.dart';
import 'app/app_index_screen.dart';
import 'auth/sign_in_screen.dart';
import 'constant/theme.dart';
import 'firebase_options.dart';
import 'commons/views/load_widget.dart';
import 'main_controller.dart';


//deploy to web, run --dart run flutter_native_splash:create
void main()async {


  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor:APPCOLOR ,
      systemNavigationBarColor:APPCOLOR,

    ),


  );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);


  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 if(!kIsWeb){
   unawaited(MobileAds.instance.initialize());
 }
await initializeLocalBooksStorage();

  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider<MainController>(create: (_)=>MainController()),
          ChangeNotifierProvider<CreateUserController>(create: (_)=>CreateUserController()),
          ChangeNotifierProvider<PublishController>(create: (_)=>PublishController()),
          ChangeNotifierProvider<StoryViewerUiController>(create: (_)=>StoryViewerUiController()),
          ChangeNotifierProvider<InAppPurchaseUtils>(create: (_)=>InAppPurchaseUtils()),
          ChangeNotifierProvider<LocalBooksController>(create: (_)=>LocalBooksController()),
          ChangeNotifierProvider<TabletUIController>(create: (_)=>TabletUIController()),
        ],
        child :  MaterialApp.router(
          // home: AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen()),

            debugShowCheckedModeBanner: false,
            color: Colors.black,


            theme: lightTheme,
            routerConfig:router,

        )
      )
     );
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _counter = 0;
  late AppLifecycleReactor _appLifecycleReactor;

  int selectedIndex =!kDebugMode?0: 4;
  late DateTime currentBackPressTime;
  TextEditingController controller = TextEditingController();
  String searchText = "";
  checkConectivity()async{

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        selectedIndex =2;
      });
      showToast("No Internet Connection");
    }

  }
  @override
  initState(){
    super.initState();
    MainController().updateApp(context);
    checkConectivity();

      AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
      _appLifecycleReactor = AppLifecycleReactor(
          appOpenAdManager: appOpenAdManager);

  }
  @override
  Widget build(BuildContext context) {


    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(content: Text("back again to exit"),),
          child:MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide>600?
              TabletView()
              : Scaffold(
            appBar: AppBar(
automaticallyImplyLeading: false,
              toolbarHeight: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor:c.isLightMode?Colors.black: Colors.white
                ),
            ),
            body:Stack(
              children:[
                [
                  HomeBooksIndexScreen(),
                  SearchIndexScreen(),
                  // SearchResultScreen(),
                  DownloadedIndexScreen(),
                  // if(!isManagement)  LocalBooksIndexScreen(),

                  // MeIndexScreen(),
                  AppIndexScreen(),
                  if(isManagement) CreatorIndexScreen(),

                  if(isManagement)ManagementIndexScreen()

                ][selectedIndex]
              ,
              Positioned(
                bottom: 5,
                left:0,
                right:0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: BottomBar(

                      child:(fontSize,iconSize)=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: listOfBar.map((Bar v){
                      bool isSelected = selectedIndex == listOfBar.indexOf(v);
                      return IconButton(
                          onPressed: (){
                            setState(() {
                              selectedIndex = listOfBar.indexOf(v);
                            });
                          },
                          icon:Icon(isSelected? v.activeIcon:v.passiveIcon,
                            size:iconSize,
                            color: isSelected? colorRed:Colors.white,));
                    }).toList(),
                  )),
                )

              )
            ]),


          ),
        ),
      ),
    );
  }
}


List<Bar> listOfBar = [
  Bar(
      title: "home",
      activeIcon:  EneftyIcons.home_2_bold,
      passiveIcon: EneftyIcons.home_2_outline
  ),
  Bar(
      title: "Explore",
      activeIcon: Icons.explore,
      passiveIcon: Icons.explore_outlined
  ),

 Bar(
      title: "local",
      activeIcon: Icons.download_done_sharp,
      passiveIcon:Icons.download_outlined
  ),
  Bar(
      title: "me",
      activeIcon: EneftyIcons.emoji_happy_bold,
      passiveIcon: EneftyIcons.emoji_happy_outline
  ),
  if(isManagement)Bar(
      title: "Writers",
      activeIcon: Icons.edit,
      passiveIcon: Icons.edit_outlined
  ),
  if(isManagement)Bar(
      title: "Management",
      activeIcon: Icons.settings,
      passiveIcon: Icons.settings_outlined
  ),

];
class Bar{
  Bar({
    this.title = "home",
    this.activeIcon = Icons.home,
    this.passiveIcon = Icons.home_outlined,
  });
  String title;
    IconData activeIcon;
  IconData passiveIcon;
}
goto(BuildContext context,Widget screen){
  Navigator.push(context, PageRouteBuilder(pageBuilder: (context,_,__){
    return screen;
  }));
}
gotoReplace(BuildContext context,Widget screen){
  Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context,_,__){
    return screen;
  }));}


final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
       // name:Routes.Home.name,
      path: '/',
      builder: (context, state) =>
      // MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide>600?
      //     TabletAuthView():
          FirstTimerScreen(child: AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen(child: MainApp(),))),

     routes: [
       GoRoute(
           path: 'privacy',
           builder: (context, state) => MarkdownScreen(data: privacyPolicy)
       ),
       GoRoute(
           path: 'terms',
           builder: (context, state) => MarkdownScreen(data: termsOfService)
       ),
       GoRoute(
         name: Routes.Library.name,
         path: "library",
         builder: (context,state){
           return SearchIndexScreen();
         },
       routes:[
         GoRoute(
           name: Routes.BookDetailsScreen.name,
           path: ":bookId",
           builder: (context,state){
             String bookId = state.pathParameters["bookId"] ?? "";
             return
               AuthGate(isSignedInChild:ScreenAdapter(bookId: bookId), isNotSignedInChild: SignInScreen(child: ScreenAdapter(bookId: bookId)));

           },),

         GoRoute(
           path: "query",
           builder: (context, state) {

             return const SizedBox();
           },
           routes: [
             GoRoute(path: "novels",
             builder: (context,state){

               return
                 AuthGate(isSignedInChild: GenreIndexScreen(currentGenre:  "Novels"), isNotSignedInChild: SignInScreen(child:GenreIndexScreen(currentGenre:  "Novels")));
             },
               routes:[
                 GoRoute(path: ":subCategory",
                     builder: (context,state){
                       String subCategory = state.pathParameters["subCategory"] ??"";



                       return

                         AuthGate(isSignedInChild: page(context,"Novels", subCategory.toCapitalized), isNotSignedInChild: SignInScreen(child:page(context,"Novels", subCategory.toCapitalized)))
                            ;
                     },)
               ]
             )
           ]
         ),
       ]
       ),
       GoRoute(
         name: Routes.Story.name,
         path: "story",
         builder: (context,state){
           return SizedBox();
         },
       routes:[
         GoRoute(
           name: Routes.StoryViewer.name,
           path: ":storyId",
           builder: (context,state){
             String storyId = state.pathParameters["storyId"] ?? "";
             return
               AuthGate(isSignedInChild: StoryScreenAdapter(storyId: storyId), isNotSignedInChild:  StoryScreenAdapter(storyId: storyId));

            ;
           },)
       ]
       ),
       GoRoute(
         name: Routes.Creators.name,
         path: "creators",
         builder: (context,state){
           return
             AuthGate(isSignedInChild:CreatorIndexScreen(), isNotSignedInChild: SignInScreen(child:CreatorIndexScreen()));

           ;
         },)
     ]
      ),


  ],
);

enum Routes{
  Home,
  Library,
  Story,
  BookDetailsScreen,
  StoryViewer,
  Terms,
  Policy,
  Creators,
  Query
}