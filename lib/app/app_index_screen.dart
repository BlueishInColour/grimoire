import 'dart:io';
import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:grimoire/app/feedback_screen.dart';
import 'package:grimoire/app/privacy-policy.dart';
import 'package:grimoire/app/terms_of_service.dart';
import 'package:grimoire/auth/log_out_dialog.dart';
import 'package:grimoire/auth/sign_in_screen.dart';
import 'package:grimoire/local/downloaded_index_screen.dart';
import 'package:grimoire/local/local_books_index_screen.dart';
import 'package:grimoire/management/management_index_screen.dart';
import 'package:grimoire/tablet/tablet_view.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/app/bookmark_index_screen.dart';
import 'package:grimoire/publish/my_books_index_screen.dart';
import 'package:grimoire/app/private_book_index_screen.dart';
import 'package:grimoire/app/share_books_index_screen.dart';
import 'package:grimoire/auth/create_user_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rate_us_on_store/rate_us_on_store.dart';

import '../auth/auth_service.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/dictionary_view.dart';
import '../constant/CONSTANT.dart';
import '../home_books/book_detail_screen.dart';
import '../read/markdown_screen.dart';
import '../commons/views/not_for_web.dart';
import '../models/book_model.dart';
import '../publish/publish_write_edit_screen.dart';
import '../search_and_genre/search_index_screen.dart';
import 'ads_mine_view.dart';
import 'history_index_screen.dart';
import 'package:launch_app_store/launch_app_store.dart';
class AppIndexScreen extends StatefulWidget {
  const AppIndexScreen({super.key,this.iconSize = 22});
  final double iconSize;
  @override
  State<AppIndexScreen> createState() => _AppIndexScreenState();
}

class _AppIndexScreenState extends State<AppIndexScreen> {
  Widget listTile(tab v){
    return Consumer<MainController>(
      builder:(context,c,child)=> ListTile(
        onTap:v.onTap,
        leading: Icon(v.icon,
          color: Colors.white70,
          size: widget.iconSize,

        ),
        title: Row(
          children: [
            Expanded(
              child: Text(v.title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w700
                    ,
                    color: Colors.white70
                ),),
            ),
            //   color:c.isLightMode? Colors.black54:Colors.white54,),

          ],
        ),
        // trailing:  v.child != null?v.child!: Icon(Icons.arrow_forward_ios_rounded,size: 10,)
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
              color:Colors.white24
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
      builder:(context,c,child)=> Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset("assets/book_cover.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              fit: BoxFit.fitHeight,).blurred(
                blur: 10,
                blurColor: Colors.black45
            ),
            NestedScrollView(
              headerSliverBuilder: (_,__)=>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  snap: true,
                  floating: true,

                  forceMaterialTransparency: true,
                  shadowColor: Colors.transparent,
                  toolbarHeight: 70,
                  title:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        // onTap: (){goto(context, SignUpScreen(editing: true,));},
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL ??""
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19.0),
                          child: Text(FirebaseAuth.instance.currentUser!.displayName??"",
                            overflow: TextOverflow.fade,

                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 15
                            ),),
                        ),
                      )
                    ],
                  ),

                ),
              ],
              body: Stack(

                children: [



                  SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.transparent,

                      body: ListView(
                        children: [
                          listTileColumn(listOfCollections(context)),
                          listTileColumn(listOfInApp(context)),
                          listTileColumn(listOfGoogleTabs(context)),
                          listTileColumn(listOfLinksTabs(context)),
                          listTileColumn(listOfApp(context)),
                          SizedBox(height: 50,),

                          Column(children: [
                            TextButton(onPressed: (){
                              showDialog(context: context, builder: (context){
                                return logoutDialog(context);
                              });
                            }, child: Text("Log Out",
                              style: GoogleFonts.montserrat(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.w900
                              ),))
                          ],),
                          SizedBox(height: 250,)
                        ],
                      ),
                      bottomNavigationBar: adaptiveAdsView(
                          AdHelper.getAdmobAdId(adsName:Ads.addUnitId7)

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<tab> listOfCollections (BuildContext   context)=> [



];
List<tab> listOfInApp (BuildContext   context,{bool isTablet = false})=> [

  //  tab(title: "History",      onTap: (){
  //   if(!isTablet) goto(context, HistoryIndexScreen());
  //   else ggoto(context, 1);
  //
  // },
  //     icon: Icons.history),
  // if(!kIsWeb) tab(title: "Local Books",      onTap: (){
  //    goto(context, LocalBooksIndexScreen());
  //
  //  },
  //      icon: Icons.download_outlined),


  tab(title: "Downloads",      onTap: () {
    if (!isTablet)
      goto(context, DownloadedIndexScreen());
    else
      ggoto(context, 5);
  },
      icon: Icons.download_done_sharp),

  // tab(title: "Find Authors",      onTap: (){},
  //     icon: Icons.person_2_outlined),

  tab(title: "Search ",      onTap: (){
    if(!isTablet) goto(context,SearchResultScreen());
    else  ggoto(context, 3);

  },
      icon: Icons.search),

  // tab(title: "Share Books Offline",      onTap: (){
  //   // goto(context, ShareBooksIndexScreen());
  // },
  //     icon: Icons.share_outlined),

];List<tab> listOfGoogleTabs(BuildContext   context) => [

  //
  // tab(title: "Dark Mode",
  //     iconColor: Colors.black,      onTap: (){},
  //     child: darkModeSwitch(context),
  //
  //     icon:Icons.dark_mode_outlined),
  tab(
      iconColor: Colors.green.shade900,
      icon: Icons.android_outlined,
      title: kIsWeb?"Install App":"Update App",
      onTap: ()async{await rateUs("com.blueishincolour.grimoire");}),
  tab(title: "Rate Us",
      iconColor: Colors.amber.shade900,
      icon: Icons.star_outline,
      onTap: ()async{await rateUs("com.blueishincolour.grimoire");}
  ), 
tab(title: "Buy Us a Coffee",
iconColor: Colors.amber.shade900,
icon: EneftyIcons.coffee_outline,
onTap: ()async{await EasyLauncher.url(url: "https://buymeacoffee.com/grimoire_live",
mode: Mode.externalApp);}
),



];
List<tab> listOfLinksTabs(BuildContext context) => [
  tab(title: "Publish Book",      onTap: ()async{
    // await  rateUs("com.blueishincolour.grimoire_creators");
    await EasyLauncher.email(email: "blueishincolour@gmail.com",
        subject: "Writers Application",
        body: "It will be an honour write on Grimoire. Sign me up with this email address. I'll love to hear back from you soon.");

  },
      //
      icon: Icons.upload_outlined),
  tab(
      onTap: ()async{
        showToast("Opening whatsapp");
        await EasyLauncher.sendToWhatsApp(phone: librarianNumber,message:"Hi");
      },
      title: "Chat Librarian",
      icon: LineIcons.whatSApp,
      iconColor: Colors.teal
  ),
  tab(
      onTap: ()async{
        await EasyLauncher.email(email: "blueishincolour@gmail.com",subject: "Feedback");
//
      },
      title: "Feedback",
      icon: Icons.chat_bubble_outline,
      iconColor: Colors.teal

//hand shake
  ), tab(
      onTap: ()async{
        await EasyLauncher.email(email: "blueishincolour@gmail.com",subject: "Reporting a Bug");
//
      },
      title: "Report Bug",
      icon: Icons.bug_report_outlined,
      iconColor: Colors.teal
  )
];


List<tab> listOfApp(BuildContext   context) =>[
  //
  // tab(title: "Help & Feedback",
  //     iconColor: Colors.black,      onTap: (){},
  //
  //     icon:Icons.sms_outlined),
  tab(title: "Privacy Policy",
      icon:Icons.privacy_tip_outlined,

      onTap: ()async{
        await EasyLauncher.url(url: "https://grimoire.live/policy",mode: Mode.externalApp);
        // goto(context, MarkdownScreen(data: privacyPolicy));
        // goto(context, WebScreen(URL: "https://grimoire.live/privacy-policy",));
      },
      iconColor: Colors.deepOrange
    //scroll note
  ),
  tab(
      onTap: ()async{
        await EasyLauncher.url(url: "https://grimoire.live/terms",mode: Mode.externalApp);


        // goto(context, MarkdownScreen(data: termsOfService));
        //
        // goto(context, WebScreen(URL: "https://grimoire.live/terms-of-sevice",));
      },
      title: "Terms Of Service",
      icon: Icons.handshake_outlined,
      iconColor: Colors.teal

    //hand shake
  ),


  // icon: Icons.sm),
  if(isManagement)tab(title: "About Grimoire",
    iconColor: Colors.purple.shade900,      onTap: (){
     goto(context, ManagementIndexScreen());
    },

    icon: Icons.settings_outlined,),

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

rateUs(String id )async{
 if(kIsWeb){
   await EasyLauncher.url(url: "https://play.google.com/store/apps/details?id=$id"
       ,mode: Mode.externalApp);
 }

   else {
   await LaunchReview.launch(
       androidAppId: id,
       // iOSAppId: "585027354",
       showToast: false,
       writeReview: false);
 }}

openUrlLink({String url  = "https://blueishincolour.github.io/grimiore/"})async{
  await
  EasyLauncher.url(url: url,mode: Mode.externalApp);
}