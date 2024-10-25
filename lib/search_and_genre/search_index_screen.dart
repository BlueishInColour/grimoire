
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/CONSTANT.dart';
import 'dart:math' as math show pi;
import 'package:grimoire/app/app_index_screen.dart';
import 'package:grimoire/commons/paginated_view.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/search_and_genre/genre_index_screen.dart';
import 'package:grimoire/search_and_genre/search_result_screen.dart';
import 'package:provider/provider.dart';

import '../commons/book_grid_item.dart';
import 'genre_model.dart';

class SearchIndexScreen extends StatefulWidget {
  const SearchIndexScreen({super.key});

  @override
  State<SearchIndexScreen> createState() => _SearchIndexScreenState();
}

class _SearchIndexScreenState extends State<SearchIndexScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MainController>(context, listen: false).tabController =TabController(length: categories.length, vsync: this);
  }
  @override

  Widget build(BuildContext context) {

    return Consumer<MainController>(
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
              elevation:0,
              title: ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  minimumSize: WidgetStatePropertyAll(Size(500,40)),
                    alignment: Alignment.centerLeft,
                  shape:WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(20)
                    )
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.grey.shade50),
                  foregroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: (){
                  goto(context, SearchResultScreen());
                },
                icon: Icon(Icons.search),
                label: Text("search"),),
              bottom: AppBar(
                forceMaterialTransparency: true,
                shadowColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                elevation:0,

                title: SizedBox(height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: categories.map((v){
                      return sideButton(
                          size: 14,
                          v, onPressed: (){c.currentGenre =v;},isSelected: v==c.currentGenre);
                    }).toList(),
                  ),
                )
              ),
            ),
            body:GenreIndexScreen()


        ),
      ),
    );
  }
}
List<GenreModel> listOfGenre = [

];



