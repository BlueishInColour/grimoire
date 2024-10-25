

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../main_controller.dart';
import '../search_and_genre/search_index_screen.dart';

Widget tagButton(context,String genre,String subGenre){
return  Consumer<MainController>(
   builder:(context,c,child)=> ElevatedButton(
       onPressed:(){
         c.currentGenre = genre;
         c.currentsubGenre= subGenre;
         goto(context,SearchIndexScreen());},
       child:Text(subGenre)
   )
 );
}