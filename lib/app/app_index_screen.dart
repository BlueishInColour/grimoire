import 'dart:io';

import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/bookmark_index_screen.dart';
import 'package:grimoire/app/my_books_index_screen.dart';
import 'package:grimoire/app/private_book_index_screen.dart';
import 'package:grimoire/app/share_books_index_screen.dart';
import 'package:grimoire/auth/create_user_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/publish/publish_index_screen.dart';
import 'package:provider/provider.dart';
import 'package:rate_us_on_store/rate_us_on_store.dart';

import '../auth/auth_service.dart';
import '../search_and_genre/search_index_screen.dart';
import 'history_index_screen.dart';

class AppIndexScreen extends StatefulWidget {
  const AppIndexScreen({super.key});

  @override
  State<AppIndexScreen> createState() => _AppIndexScreenState();
}

class _AppIndexScreenState extends State<AppIndexScreen> {
  Widget listTile(tab v){
    return Consumer<MainController>(
      builder:(context,c,child)=> ListTile(
        onTap:v.onTap,
        leading: Icon(v.icon,
          // color: v.iconColor,
        ),
        title: Text(v.title,style: GoogleFonts.montserrat(
          fontSize: 12
        ),),
        trailing:v.child != null?v.child: Icon(Icons.arrow_forward_ios_rounded,size: 10,
          color:c.isLightMode? Colors.black54:Colors.white54,),
      ),
    );
  }

  Widget listTileColumn(List<tab> listOfTab){
    return     Consumer<MainController>(
      builder:(context,c,child)=> Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:c.isLightMode? Colors.white:Colors.black
          ),
          child: Column(children: listOfTab.map((v){
            return listTile(v);
          }).toList(),),
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<MainController>(
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

            forceMaterialTransparency: true,
            shadowColor: Colors.transparent,
            toolbarHeight: 70,
            title:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL ??""
                  ),
                ),

                 SizedBox(width: 10,),
                 Text(FirebaseAuth.instance.currentUser!.displayName??"",
                 style: GoogleFonts.montserrat(
                   fontWeight: FontWeight.w600,
                   color:c.isLightMode?Colors.black87: Colors.white70,
                   fontSize: 15
                 ),)
              ],
            ),
            actions: [
              // IconButton(onPressed: (){goto(context, CreateUserScreen());},
              //     icon: Icon(EneftyIcons.user_edit_outline)),
              SizedBox(width: 5,)
            ],
          ),
          body: ListView(
            children: [
              listTileColumn(listOfCollections(context)),
              listTileColumn(listOfInApp(context)),
              listTileColumn(listOfGoogleTabs(context)),

              listTileColumn(listOfLinksTabs(context)),
              listTileColumn(listOfApp),
              SizedBox(height: 50,),

              Column(children: [
                TextButton(onPressed: (){
                  AuthService().logout();
                }, child: Text("Log Out",
                style: GoogleFonts.montserrat(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w900
                ),))
              ],),
              SizedBox(height: 150,)
            ],
          ),
        ),
      ),
    );
  }
}

List<tab> listOfCollections (context)=> [
  tab(title: "History",      onTap: (){
    goto(context, HistoryIndexScreen());

  },
      icon: Icons.history),

  tab(title: "Bookmarked",      onTap: (){
    goto(context, BookmarkIndexScreen());
  },
      icon: Icons.bookmark_added_outlined),


  tab(title: "My Books",      onTap: (){
    goto(context, MyBooksIndexScreen());
  },
      icon: Icons.book_outlined),


  tab(title: "Private Books",      onTap: (){
    goto(context, PrivateBooksIndexScreen());

  },
      icon: Icons.lock_outline),
];
List<tab> listOfInApp (context)=> [

  tab(title: "Publish Book",      onTap: (){
    goto(context, PublishIndexScreen());

  },
  //
      icon: Icons.upload_outlined),
  // tab(title: "Find Authors",      onTap: (){},
  //     icon: Icons.person_2_outlined),

  tab(title: "Find Books",      onTap: (){
    goto(context,SearchIndexScreen());
  },

      icon: Icons.search),
  // tab(title: "Share Books Offline",      onTap: (){
  //   // goto(context, ShareBooksIndexScreen());
  // },
  //     icon: Icons.share_outlined),

];List<tab> listOfGoogleTabs(context) => [

  //
  // tab(title: "Dark Mode",
  //     iconColor: Colors.black,      onTap: (){},
  //     child: darkModeSwitch(context),
  //
  //     icon:Icons.dark_mode_outlined),
  tab(
    iconColor: Colors.green.shade900,
      icon: Icons.upload_outlined,
      title: "Upgrade",
  onTap: ()async{await rateUs();}),
  tab(title: "Rate Us",
      iconColor: Colors.amber.shade900,
      icon: Icons.star_outline,
      onTap: ()async{await rateUs();}
  ),
  // tab(title: "Improve & Design Grimoire",
  //     iconColor: Colors.amber.shade900,
  //     icon: Icons.color_lens_outlined,
  //     onTap: (){rateUs();}
  // ),

];
List<tab> listOfLinksTabs(BuildContext context) => [
];


List<tab> listOfApp =[
  //
  // tab(title: "Help & Feedback",
  //     iconColor: Colors.black,      onTap: (){},
  //
  //     icon:Icons.sms_outlined),
  tab(title: "Privacy Policy",
      icon:Icons.privacy_tip_outlined,
      onTap: (){openUrlLink();},


      iconColor: Colors.deepOrange
    //scroll note
  ),
  tab(
      onTap: (){openUrlLink();},
      title: "User Agreement",
      icon: Icons.handshake_outlined,
      iconColor: Colors.teal

    //hand shake
  ),

  // // icon: Icons.sm),
  // tab(title: "About Grimoire",
  //   iconColor: Colors.purple.shade900,      onTap: (){
  //     openUrlLink();
  //   },
  //
  //   icon: Icons.warning_amber_rounded,),

];

Widget darkModeSwitch(context) {
  return Consumer<MainController>(
    builder:(context,c,child)=> Switch(
      activeColor: Colors.green,

      value: c.themeMode ==ThemeMode.dark?true:false,
      onChanged: (v){
        MainController themeNotifier = Provider.of<MainController>(context, listen: false);
        if (themeNotifier.themeMode == ThemeMode.light) {
          themeNotifier.setTheme(ThemeMode.dark);
        } else {
          themeNotifier.setTheme(ThemeMode.light);
        }
      },

    ),
  );
}

class tab{
  tab({
    required this.title,
    this.child,
   required this.onTap,
    this.icon = Icons.star,
    this.iconColor = Colors.blue
});
  String title;
  Widget? child;
  Function() onTap;
  IconData icon;
  Color iconColor;
}

//
//
// Future<void> getPackageData() async {
//   PackageInfo _packageInfo = await PackageManager.getPackageInfo();
// }
// updateApp()async{
//
//   /// Android
//   if (Platform.isAndroid) {
//     InAppUpdateManager manager = InAppUpdateManager();
//     AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
//     if (appUpdateInfo == null) return; //Exception
//     if (appUpdateInfo.updateAvailability == UpdateAvailability.developerTriggeredUpdateInProgress) {
//       ///If an in-app update is already running, resume the update.
//       String? message = await manager.startAnUpdate(type: AppUpdateType.immediate);
//       ///message return null when run update success
//     } else if (appUpdateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
//       ///Update available
//       if (appUpdateInfo.immediateAllowed) {
//         debugPrint('Start an immediate update');
//         String? message = await manager.startAnUpdate(type: AppUpdateType.immediate);
//         ///message return null when run update success
//       } else if (appUpdateInfo.flexibleAllowed) {
//         debugPrint('Start an flexible update');
//         String? message = await manager.startAnUpdate(type: AppUpdateType.flexible);
//         ///message return null when run update success
//       } else {
//         debugPrint('Update available. Immediate & Flexible Update Flow not allow');
//       }
//     }}
// }

rateUs(){
  RateUsOnStore(androidPackageName: "com.blueishincolour.grimoire", appstoreAppId: "284882215").launch();

  }

  openUrlLink({String url  = "https://blueishincolour.github.io/grimiore/"})async{
await
  EasyLauncher.url(url: url,mode: Mode.externalApp);
  }