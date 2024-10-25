import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/wrapped_sections.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:provider/provider.dart';

import '../CONSTANT.dart';

class FirstTimerScreen extends StatefulWidget {
  const FirstTimerScreen({super.key});

  @override
  State<FirstTimerScreen> createState() => _FirstTimerScreenState();
}

class _FirstTimerScreenState extends State<FirstTimerScreen> {
  @override
  Widget build(BuildContext context) {
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
    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 30,),
              Text("pick at least 3 tags you'd like to read about",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w900,
                fontSize: 20
              ),),
              SizedBox(height: 20,),


             FutureBuilder<List<String>>(
               future: c.getListOfLikes(),
               builder: (context, snapshot) {
                 List<String> listOfLikes = snapshot.data ??[];
                 return Wrap(
                   children:
                   categories.map((v){return wrap(v, listOfLikes.contains(v),
                       onPressed: (v){
                     if(listOfLikes.contains(v)){c.removeFromListOfLikes(v);
                       }
                     else c.addToListOfLikes(v);
                     },
                       selectedColor: Colors.black,unSelectedColor: Colors.blue);}).toList(),
                 );
               }
             )
                ],
          ),

        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              c.updateFirstTime();
              gotoReplace(context, MainApp());
            },
            child: Text("Continue"),
          ),
        ),
      ),
    );
  }
}
