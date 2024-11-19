//
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
//
// import 'auth_service.dart';
// import 'controller/create_user_controller.dart';
//
// class CreateUserScreen extends StatefulWidget {
//   const     CreateUserScreen({super.key,bool this.showBackButton = false});
// final bool showBackButton ;
//   @override
//   State<CreateUserScreen> createState() => _CreateUserScreenState();
// }
//
// class _CreateUserScreenState extends State<CreateUserScreen> with TickerProviderStateMixin {
// bool isLoading = false;
//   late TabController tabController ;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(length: listOfTabs.length, vsync: this);
//   }
//   var buttonFilledStyle = ButtonStyle(
//
//     shape: MaterialStatePropertyAll(
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//     padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
//     minimumSize: WidgetStatePropertyAll(Size(400,40)),
//     backgroundColor: WidgetStatePropertyAll(Colors.purple),
//     foregroundColor: MaterialStatePropertyAll(Colors.black),
//   );
//   final textStyle = TextStyle(color: Colors.black87);
//
//   final  headerStyle = GoogleFonts.merriweather(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w800);
//
//   InputDecoration? inputStyle(String hintText) => InputDecoration(
//     hintText: hintText,
//
//   );
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<CreateUserController>(
//       builder:(context,c,child)=> Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: 300,
//                 height: 400,
//                 decoration: BoxDecoration(
//                     color: Colors.white70,
//                     borderRadius: BorderRadius.circular(10)
//                 ),child:
//               Column(
//                 children: [
//                   TabBar(
//                       isScrollable: true,
//                       tabAlignment: TabAlignment.start,
//                       indicatorColor: Colors.green.shade900,
//                       labelColor: Colors.green.shade900,
//                       controller: tabController,
//                       tabs: listOfTabs.map((v){return Tab(text: v,);}).toList()),
//
//                   Expanded(child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TabBarView(
//                       controller: tabController,
//                       children: [
//                         setProfilePictureView(),
//                         setNamesView(),
//                         setAddressAndBirthday(),
//
//                       ],
//                     ),
//                   )),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           minimumSize: WidgetStatePropertyAll(Size(300,40)),
//                           backgroundColor: WidgetStatePropertyAll(Colors.green.shade900),
//                           foregroundColor: WidgetStatePropertyAll(Colors.white70),
//                           padding: WidgetStatePropertyAll(EdgeInsets.all(6)),
//
//                           shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
//                       ),
//                       child:c.isLoading?CupertinoActivityIndicator(color: Colors.white70,): Text("done!"),
//                       onPressed: ()async{
//
//
//                              if(!c.isLoading) await  c.createUser(context);
//
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               ),
//               SizedBox(height: 15,),
//               TextButton(onPressed: (){
//                 AuthService().logout();
//               }, child: Text("logout",style:GoogleFonts.merriweather(
//                   color: Colors.red.shade700,
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600
//               ),))
//             ],
//           )),
//       ));
//   }
//
//  Widget setProfilePictureView() {
//
//     final buttonStyle= ButtonStyle(
//         foregroundColor: WidgetStatePropertyAll(Colors.green.shade900),
//         shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.green.shade900,width: 5))));
//     return Consumer<CreateUserController>(
//       builder:(context,c,child){
//         return Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Center(child: ListView(
//             children: [
//               SizedBox(height: 10,),
//               CircleAvatar(radius: 100,
//                 backgroundImage: NetworkImage(
//                     FirebaseAuth.instance.currentUser!.photoURL ??""
//                 ),
//                 // child:IconButton.outlined(onPressed: ()async{await c.captureProfilePicture(context);}, icon: Icon(Icons.camera_alt_outlined),style : buttonStyle,),
//
//         ),
//
//             ],
//           ),),
//         );
//       },
//     );
//  }
//
//  Widget setNamesView() {
//     return Consumer<CreateUserController>(
//       builder:(context,c,child)=> SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Center(
//             child: Column(
//                   children: [
//                     TextField(
//                       controller: c.full_name,
//                       style: textStyle,
//                       decoration: inputStyle("user name, brand name, or whatever"),
//                     ),
//
//
//                   ],
//
//             ),
//           ),
//         ),
//       ),
//     );
//
//  }
//
//  Widget setAddressAndBirthday() {
//    return Consumer<CreateUserController>(
//      builder:(context,c,child)=> Padding(
//        padding: const EdgeInsets.all(5.0),
//        child: Center(
//          child: ListView(
//            children: [
//              TextField(
//                controller: c.phone_number,
//                style: textStyle,
//
//                decoration: inputStyle("phone number"),
//              ),
//              TextField(
//                controller: c.home_address,
//                style: textStyle,
//
//                decoration: inputStyle("address"),
//              ),
//              TextField(
//                controller: c.city,
//                style: textStyle,
//                decoration: inputStyle("city"),
//              ),
//              TextField(
//                controller: c.state,
//                style: textStyle,
//                decoration: inputStyle("state"),
//              ),
//              TextField(
//                controller: c.country,
//                style: textStyle,
//                decoration: inputStyle("country"),
//
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//
// final listOfTabs = ["profile picture","names","personal info"];}