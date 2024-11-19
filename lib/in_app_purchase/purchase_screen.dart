import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/bottom.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:provider/provider.dart';
import '../in_app_purchase/in_app_purchase_controller.dart';

class PurchaseScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-100,
      child:Consumer<InAppPurchaseUtils>(
      builder: (context,c,child)=>
       Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text("Go Premium",
                    style: GoogleFonts.merriweather(
                      fontSize: 30,
                      fontWeight: FontWeight.w900
                    ),),
                    SizedBox(width: 15,),

                    Icon(EneftyIcons.magic_star_bold,
                    color: Colors.purple.shade900,
                    size: 30,)
                  ],
                ),
                listTile(context,text:"No Ads",icon:Icons.ads_click),
                listTile(context,text:"Get Verification plus Badge",icon:Icons.verified_outlined),
                listTile(context,text:"Premium Books Available",icon:Icons.explore_outlined),
                listTile(context,text:"Chat Librarian Anytime",icon:Icons.chat_outlined),
                listTile(context,text:"More Offline Downloads",icon:Icons.download_done_sharp),

                Image(
                  image: Svg("assets/image6.svg",),
                ),



              ],

            ),
          ),
          bottomNavigationBar:  StreamBuilder<bool>(
            stream: c.isStoreAvailable(),
            builder: (context, snapshot) {
              return BottomBar(child: (fontSize,iconSize){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return loadWidget(color: Colors.white70);
                  }
                  else if(snapshot.hasData && snapshot.data !=null && snapshot.data ==true) {
                 return    TextButton(
                        onPressed: () async {
                          await c.buyConsumableProduct(c.products[0].id);
                        },
                        child: Text(
                          "Buy Premium",
                          style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w800,
                              fontSize: fontSize,
                              color: Colors.white70),
                        ));
                  }
                  else return Center(
                    child: Text("Unavailable For Now",
                        style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.w800,
                            fontSize: fontSize,
                            color: Colors.white70),
                      ),
                  );
                });
            }
          ),
        ),)

    );
  }

  Widget listTile(context,{required String text, required IconData icon}) {
    return  SizedBox(
      // height: 100,
      //   width: MediaQuery.of(context).size.width,
      child: ListTile(
      // leading: Text(".",style: GoogleFonts.montserrat(
      //   fontWeight: FontWeight.w900,
      //   fontSize: 20
      // ),),
        title: Text(text,
        style: GoogleFonts.aclonica(

        ),),
        leading: Icon(icon),
      ),
    );
  }
}

showPremiumPurchaseScreen(context){
  showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: Colors.black,

      isScrollControlled: true,
      shape: RoundedRectangleBorder(),
      anchorPoint: Offset(0, MediaQuery.of(context).size.height-200),


      context: context, builder: (context){
    return   PurchaseScreen();
  });
}