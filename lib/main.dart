import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:grimoire/auth/auth_gate.dart';
import 'package:grimoire/auth/controller/create_user_controller.dart';
import 'package:grimoire/home_books/home_books_index_screen.dart';
import 'package:grimoire/local/local_books_index_screen.dart';
import 'package:grimoire/local/offline_index_screen.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/publish/publish_index_screen.dart';
import 'package:grimoire/search_and_genre/search_index_screen.dart';
import 'package:grimoire/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import '../CONSTANT.dart';
import 'app/app_index_screen.dart';
import 'auth/sign_in_screen.dart';
import 'firebase_options.dart';
import 'load_widget.dart';
import 'main_controller.dart';

void main()async {



  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor:APPCOLOR ,
      systemNavigationBarColor:APPCOLOR,
    ),


  );

  WidgetsFlutterBinding.ensureInitialized();

  // unawaited(MobileAds.instance.initialize());
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FlutterDownloader.initialize(
  //     debug: true, // optional: set to false to disable printing logs to console (default: true)
  //     ignoreSsl: true // option: set to false to disable working with http links (default: false)
  // );

  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider<MainController>(create: (_)=>MainController()),
          ChangeNotifierProvider<CreateUserController>(create: (_)=>CreateUserController()),
          ChangeNotifierProvider<PublishController>(create: (_)=>PublishController()),
        ],
        child :  Consumer<MainController>(
          builder:(context,c,child)=> MaterialApp(
              debugShowCheckedModeBanner: false,
              color: Colors.blue,

              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: c.themeMode, // Can be ThemeMode.light or ThemeMode.dark
              home: SplashScreen()),
        )
      )
     );
}




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: kDebugMode?0:5),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthGate(
                isNotSignedInChild: SignInScreen(),
                  isSignedInChild: MainApp(),
              )
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor:Colors.black

        ),
      ),
      backgroundColor:Colors.black,
      body: Center(
        child: Image.asset("assets/icon.png",height: 150,width: 150,)
      ),
    );
  }
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  late DateTime currentBackPressTime;
  // checkConectivity()async{
  //
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult.contains(ConnectivityResult.none)) {
  //     setState(() {
  //       selectedIndex =2;
  //     });
  //     MainController().showSnackBar(context, "no internet connection");
  //   }
  //
  // }
  @override
  initState(){
    super.initState();
    MainController().updateApp(context);
    // checkConectivity();


  }
  @override
  Widget build(BuildContext context) {


    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(content: Text("back again to exit"),),
          child: Scaffold(
            appBar: AppBar(
automaticallyImplyLeading: false,
              toolbarHeight: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor:c.isLightMode?Colors.black: Colors.white
                ),
            ),
            body:[
              // HomeIndexScreen(),
              HomeBooksIndexScreen(),
              SearchIndexScreen(),
            LocalBooksIndexScreen(),
              // MeIndexScreen(),
              AppIndexScreen()
            ][selectedIndex],
            floatingActionButton: FloatingActionButton(shape: CircleBorder(),
              child: Icon(EneftyIcons.add_outline),
              onPressed: () {
                goto(context, PublishIndexScreen());
              },
              //params
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:

            AnimatedBottomNavigationBar(

              backgroundColor:c.isLightMode? APPCOLOR:Colors.white,
              activeColor:c.isLightMode? Colors.white:Colors.black,
              inactiveColor:c.isLightMode? Colors.white54:Colors.black54,
              icons: listOfBar.map((v){return v.passiveIcon;}).toList(),
              activeIndex: selectedIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,


              onTap: (index) => setState(() => selectedIndex = index),

              //other params
            ),

          ),
        ),
      ),
    );
  }
}


List<Bar> listOfBar = [
  Bar(
      title: "home",
      activeIcon: Icons.home,
      passiveIcon: EneftyIcons.home_2_outline
  ),
  Bar(
      title: "search",
      activeIcon: Icons.search,
      passiveIcon: EneftyIcons.search_normal_outline
  ),
  // Bar(
  //     title: "store",
  //     activeIcon: Icons.shopping_basket,
  //     passiveIcon: Icons.shopping_basket_outlined
  // ),
  Bar(
      title: "downloaded",
      activeIcon: Icons.download_done,
      passiveIcon: EneftyIcons.arrow_down_2_outline
  ),
  Bar(
      title: "me",
      activeIcon: Icons.person,
      passiveIcon: EneftyIcons.emoji_happy_outline
  ),
  // Bar(
  //     title: "app",
  //     activeIcon: Icons.settings,
  //     passiveIcon: Icons.settings_outlined
  // ),

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
  Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}
gotoReplace(BuildContext context,Widget screen){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>screen));
}