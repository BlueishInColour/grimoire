import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:grimoire/app/feedback_screen.dart';
import 'package:grimoire/app/privacy-policy.dart';
import 'package:grimoire/app/terms_of_service.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:grimoire/auth/auth_gate.dart';
import 'package:grimoire/auth/controller/create_user_controller.dart';
import 'package:grimoire/chat/chat_controller.dart';
import 'package:grimoire/commons/adapters/screen_adapter.dart';
import 'package:grimoire/commons/adapters/story_screen_adapter.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/first_timer_screen.dart';
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
import 'package:grimoire/commons/views/tablet_view.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'chat/chat_screen.dart';
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
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);


  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 if(!kIsWeb){
   unawaited(MobileAds.instance.initialize());

   await FlutterDownloader.initialize(
       debug: true, // optional: set to false to disable printing logs to console (default: true)
       ignoreSsl: true // option: set to false to disable working with http links (default: false)
   );
 }
await initializeLocalBooksStorage();

  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider<MainController>(create: (_)=>MainController()),
          ChangeNotifierProvider<CreateUserController>(create: (_)=>CreateUserController()),
          ChangeNotifierProvider<PublishController>(create: (_)=>PublishController()),
          ChangeNotifierProvider<ChatController>(create: (_)=>ChatController()),
          ChangeNotifierProvider<StoryViewerUiController>(create: (_)=>StoryViewerUiController()),
          ChangeNotifierProvider<InAppPurchaseUtils>(create: (_)=>InAppPurchaseUtils()),
          ChangeNotifierProvider<LocalBooksController>(create: (_)=>LocalBooksController()),
        ],
        child :  Consumer<MainController>(
          builder:(context,c,child)=> MaterialApp.router(
            // home: AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen()),

              debugShowCheckedModeBanner: false,
              color: Colors.blue,


              theme: lightTheme,
              routerConfig:router
          ),
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
  int selectedIndex =!kDebugMode?0: 0;
  late DateTime currentBackPressTime;
  TextEditingController controller = TextEditingController();
  String searchText = "";
  checkConectivity()async{

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        selectedIndex =3;
      });
      showToast("No Internet Connection");
    }

  }
  @override
  initState(){
    super.initState();
    MainController().updateApp(context);
    checkConectivity();


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
                  MyBooksIndexScreen(),
                  if(!isManagement)  LocalBooksIndexScreen(),

                  // MeIndexScreen(),
                  AppIndexScreen(),
                  if(isManagement)ManagementIndexScreen()

                ][selectedIndex]
              ,
              Positioned(
                bottom: 5,
                left:0,
                right:0,
                child:
                selectedIndex == 1 ?
                BottomBar(
                  child: (fontSize,iconSize)=>TextField(
                    controller: controller,
                    onChanged: (v){setState(() {
                      searchText = v;
                    });},

                    style: GoogleFonts.merriweather(
                        fontSize: fontSize,
                        color: Colors.white70
                    ),


                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (v){
                      goto(context, SearchResultScreen(searchText: v,));
                    },



                    cursorHeight: 17,
                    cursorColor: Colors.white,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        hintText: "search or ask the librarian ...",
                        hintStyle: GoogleFonts.merriweather(
                            fontSize: fontSize,
                            color: Colors.white70
                        ),
                        filled: true,

                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: (){
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              icon: Icon(EneftyIcons.home_2_outline,color: Colors.white70,size: iconSize,)),
                        ),

                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: (){
                              goto(context, ChatScreen(email: "blueishincolour@gmail.com",
                                messageText:searchText,

                                showMessageBar: true,));

                            },
                            icon: Icon(searchText.isEmpty?Icons.chat_bubble_outline:Icons.send,
                              color: Colors.white70,size: iconSize,
                            ),
                          ),
                        )

                    ),
                  ),
                )
                    :
                BottomBar(child:(fontSize,iconSize)=> Row(
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
                          color: isSelected? Colors.white:Colors.white70,));
                  }).toList(),
                ))

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
      title: "search",
      activeIcon: EneftyIcons.search_normal_bold,
      passiveIcon: EneftyIcons.search_normal_outline
  ),

  Bar(
      title: "Write",
      activeIcon: EneftyIcons.edit_2_bold,
      passiveIcon: EneftyIcons.edit_2_outline
  ),
  if(!isManagement)Bar(
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

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => FirstTimerScreen(child: AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen())),
      ),
    GoRoute(
      path: '/privacy',
      builder: (_, __) => MarkdownScreen(data: privacyPolicy)
    ),
      GoRoute(
      path: '/terms',
builder: (_, __) => MarkdownScreen(data: termsOfService)
    ),
    GoRoute(
      name: Routes.BookDetailsScreen.name,
      path: "/library/:bookId",
      builder: (context,state){
        String bookId = state.pathParameters["bookId"] ?? "";
        return ScreenAdapter(bookId: bookId);
      },),
    GoRoute(
      name: Routes.StoryViewer.name,
      path: "/story/:storyId",
      builder: (context,state){
        String storyId = state.pathParameters["storyId"] ?? "";
        return StoryScreenAdapter(storyId: storyId);
      },)

  ],
);

enum Routes{
  BookDetailsScreen,
  StoryViewer,
  Terms,
  Policy
}