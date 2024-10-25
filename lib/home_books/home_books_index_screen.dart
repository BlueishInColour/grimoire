import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commons/book_grid_item.dart';
import '../commons/book_rank_view.dart';
import '../search_and_genre/genre_index_screen.dart';

class HomeBooksIndexScreen extends StatefulWidget {
  const HomeBooksIndexScreen({super.key});

  @override
  State<HomeBooksIndexScreen> createState() => _HomeBooksIndexScreenState();
}

class _HomeBooksIndexScreenState extends State<HomeBooksIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          title: Text("Grimoire",style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,

          ),),),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children:[
                Text("Top 20 Count Down",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color:Colors.black87
                  ),),
                SizedBox(height: 15,),

                BookRankView(),
                SizedBox(height: 15,),
                Text("Based On Your Likes",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color:Colors.black87
                ),),

                MasonryView(listOfItem: list,
                    itemPadding: 4,
                    numberOfColumn: 4, itemBuilder: (v){
                      return BookGridItem(onTap: (){}, id: 0,title: v.title,height: v.height,);
                    }),
              ]
                    ),
          ),
      ),
    );
  }
}
