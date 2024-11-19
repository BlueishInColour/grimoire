import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:grimoire/auth/sign_in_screen.dart';
import 'package:grimoire/commons/views/first_timer_screen.dart';

import '../auth/auth_gate.dart';
import '../main.dart';
//
// class TabletAuthView extends StatefulWidget {
//   const TabletAuthView({super.key});
//
//   @override
//   State<TabletAuthView> createState() => _FoolishWithoutStateState();
// }
//
// class _FoolishWithoutStateState extends State<TabletAuthView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Row(
//         children: [
//           Expanded(flex:2,child:
//       ListView(
//         children: [
//           ImageSlideshow(
//
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height,
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             children: [
//               image(image: Svg("assets/image8.svg"),textColor: Colors.white, text: "Yo!"),
//               // image(image: Svg("assets/image5.svg"), text: "Never miss a story even at tea time"),
//               image(image: Svg("assets/image1.svg"),textColor: Colors.white,text: "Join the growing community"),
//
//               image(image: Svg("assets/image3.svg"),textColor: Colors.white, text: "capture creativity, write your story from your perspective"),
//               // image(image: Svg("assets/image4.svg"), text: "own your own space story-telling medium for free"),
//               // image(image: Svg("assets/image2.svg"), text: "monitize your content"),
//               // image(image: Svg("assets/image6.svg"),text: "write and share at your own pace"),
//             image(image: Svg("assets/image7.svg"),textColor: Colors.white, text: "All at and for your comfort")
//             ],
//             autoPlayInterval:7000,
//             indicatorColor: Colors.amber,
//             indicatorBackgroundColor: Colors.grey[700],
//
//
//           ),
//         ],
//       ),),
//           Expanded(flex: 3,child: AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen()))
//         ],
//       ),
//     );
//   }
// }
