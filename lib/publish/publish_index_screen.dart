import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/CONSTANT.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:grimoire/publish/publish_edit_screen.dart';
import 'package:provider/provider.dart';

class PublishIndexScreen extends StatefulWidget {
  const PublishIndexScreen({super.key});

  @override
  State<PublishIndexScreen> createState() => _PublishIndexScreenState();
}

class _PublishIndexScreenState extends State<PublishIndexScreen> {
  Widget notesPod({String topic = "What Youll need", List<String> notes= const[]}){
    return Consumer<MainController>(
      builder:(context,c,child)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(topic,style: GoogleFonts.montserrat(
            // color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18
          ),),
         ... notes.map((v){return ListTile(
           leading: CircleAvatar(radius: 5,backgroundColor:c.isLightMode? Colors.black:Colors.white,),
           title: Text(v,
           style: GoogleFonts.montserrat(),
           ),
         );})
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PublishController>(
      builder:(context,c,child)=> SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.clear),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Grimoire Publishing",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 30
                ),),
                SizedBox(height: 50,),

                //what you need
                notesPod(
                  topic: "What You`ll Need",
                  notes: [
                    "e-Book you own"

                  ]
                ),

                //how youll earn
                notesPod(
                  topic: "How you`ll be Rewarded",
                  notes: [
                    "In App Advertising",
                    "Buy Me A Coffee",
                    "Hardcopy Purchase"
                  ]
                ),
                SizedBox(height: 100,),

                //get started
                ElevatedButton(

                    onPressed: (){
                      goto(context, PublishEditScreen());
                    }, child: Text("Continue"))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
