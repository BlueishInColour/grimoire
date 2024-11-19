import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/auth/auth_gate.dart';
import 'package:grimoire/auth/sign_in_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:provider/provider.dart';

import '../../constant/CONSTANT.dart';
import 'bottom.dart';
import 'load_widget.dart';
import 'package:is_first_run/is_first_run.dart';

class FirstTimerScreen extends StatefulWidget {
  const FirstTimerScreen({super.key,required this.child});
final Widget child;
  @override
  State<FirstTimerScreen> createState() => _FirstTimerScreenState();
}

class _FirstTimerScreenState extends State<FirstTimerScreen> {
  makeFirstTime ()async{
  await  IsFirstRun.reset();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // makeFirstTime();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<MainController>(
      builder:(context,c,child)=> FutureBuilder<bool?>(
        future: IsFirstRun.isFirstRun(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return loadWidget(color: Colors.black);
          }

         else if(snapshot.data == true) {


            return Scaffold(
                backgroundColor: Colors.grey[100],
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageSlideshow(

                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    children: [
                      image(image: Svg("assets/image8.svg"), text: "Novels & More at 'Ur Fingertip"),
                      // image(image: Svg("assets/image5.svg"), text: "Never miss a story even at tea time"),
                      image(image: Svg("assets/image1.svg"),text: "Join the growing community"),

                      image(image: Svg("assets/image3.svg"), text: "capture creativity, write your story from your perspective"),
                      // image(image: Svg("assets/image4.svg"), text: "own your own space story-telling medium for free"),
                      image(image: Svg("assets/image2.svg"), text: "monitize your content"),
                      // image(image: Svg("assets/image6.svg"),text: "write and share at your own pace"),
                      Column(
                        children: [
                          Expanded(child: image(image: Svg("assets/image7.svg"), text: "All at your comfort")),
                          BottomBar(
                            child:(fontSize,iconSize)=>
                                TextButton.icon(onPressed: (){
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context,_,__){
    return  AuthGate(isSignedInChild: MainApp(), isNotSignedInChild: SignInScreen());
    }));}

    , icon: Text("Continue",
                            style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w800,
                              fontSize: fontSize,
                              color: Colors.white70
                            ),),
                            label: Icon(Icons.arrow_forward,color: Colors.white70,size: iconSize,),),

                          ),
                          SizedBox(height: 100,)
                        ],
                      ),

                    ],
                    indicatorColor: Colors.amber,
                    indicatorBackgroundColor: Colors.grey[700],


                  ),
                ));

         }
         else  return widget.child;

        }
      ),
    );
  }
}


Widget image({required ImageProvider<Object> image,String text = "binge short stories"}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(text,
        style: GoogleFonts.merriweather(
          fontSize: 30,
          fontWeight: FontWeight.w900,

        ),),

      Container(
        child: Image(image: image),
        
      ),

    ],
  );
}


// import 'package:flutter/material.dart';

class PickTopics extends StatefulWidget {
  const PickTopics({super.key});

  @override
  State<PickTopics> createState() => _PickTopicsState();
}

class _PickTopicsState extends State<PickTopics> {
  List<String> localListOfLikes = [];
  addToList(v){
    setState(() {
      localListOfLikes.add(v);
    });
  }
  removeFromList(v){
    setState(() {
      localListOfLikes.remove(v);
    });
  }
  getListOfLikes()async{
    List<String> list = await Provider.of<MainController>(context).listOfLikes;
    setState(() {
      localListOfLikes.addAll(list);
    });

  }

  Widget wrap(String title,bool isSelected,{Color selectedColor =  Colors.blue,Color unSelectedColor =const  Color.fromRGBO(12, 21, 12, 12),required Function(String) onPressed}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),

      child: FilledButton.tonal(

          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(60,40)),

              textStyle: WidgetStatePropertyAll(
                TextStyle(
                  color:isSelected?Colors.white70: Colors.black38,
                ),

              ),

              backgroundColor: WidgetStatePropertyAll(isSelected?selectedColor:null)
              ,   padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))
          ),
          onPressed:()=>onPressed(title), child: Text(title,style: TextStyle(
          color:isSelected?Colors.white70: Colors.black54,
          fontSize:14,
          overflow: TextOverflow.ellipsis


      ),)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Text("pick at least 4 things you'd care to read about",
              style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.w900,
                  fontSize: 20
              ),),
            SizedBox(height: 20,),
      
      
            Wrap(
              children:
              categories.map((v){return
                wrap(v,
                    localListOfLikes.contains(v),
                    onPressed: (v){
                      if(localListOfLikes.contains(v)){removeFromList(v);
                      }
                      else addToList(v);
                    },
                    selectedColor: Colors.purple,unSelectedColor: Colors.blue);}).toList(),
            )
          ],
        ),
      
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: localListOfLikes.length >3?Colors.amber.shade700:Colors.grey[400],
        onPressed: (){
             },
        icon: Icon(Icons.arrow_forward),
        label: Text("Continue"),),
    );
  }
}
