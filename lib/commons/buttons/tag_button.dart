

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../main_controller.dart';
import '../../search_and_genre/search_index_screen.dart';

Widget tagButton(context,String genre,String subGenre){
return  Consumer<MainController>(
   builder:(context,c,child)=> Padding(
     padding: const EdgeInsets.symmetric(horizontal: 2.0),
     child: ElevatedButton(
       style: ButtonStyle(
         backgroundColor: WidgetStatePropertyAll(Colors.purple.shade50),
         foregroundColor: WidgetStatePropertyAll(Colors.purple.shade600),
         shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
         padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 5,vertical: 2)),
         elevation: WidgetStatePropertyAll(0),
         textStyle: WidgetStatePropertyAll(GoogleFonts.merriweather(fontSize: 10)),
         minimumSize: WidgetStatePropertyAll(Size(20,10))
       ),
         onPressed:(){
           c.currentGenre = genre;
           c.currentsubGenre= subGenre;
           goto(context,SearchResultScreen(searchText: subGenre,));},
         child:Text(subGenre)
     ),
   )
 );
}