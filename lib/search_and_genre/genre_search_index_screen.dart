import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/models/genre_model.dart';

import '../commons/views/paginated_view.dart';
import '../constant/CONSTANT.dart';
import '../models/book_model.dart';

class GenreIndexScreen extends StatefulWidget {
  const GenreIndexScreen({super.key, required this.currentGenre});
  final String currentGenre;
  @override
  State<GenreIndexScreen> createState() => _GenreIndexScreenState();
}

class _GenreIndexScreenState extends State<GenreIndexScreen>with TickerProviderStateMixin {
  // late TabController tabController;
  List<String> subGenres = ["All","Latest"];
  String currentSubGenre = "All";

  fetchSubGenres()async{
  final DocumentSnapshot<Map<String, dynamic>>  res =await  FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).get();
  Map<String,dynamic> data = res.data() ?? {};
  GenreModel genreModel = GenreModel.fromJson(data);


  setState(() {
    subGenres.addAll(genreModel.subGenres);
  });
  return subGenres;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSubGenres();
  }

  @override

  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
appBar: AppBar(
  foregroundColor: Colors.white60,
),
        body: Row(
          children: [
            Container(
              width: 70,
              decoration:BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15))
              ),
              child: ListView.builder(

                  itemCount: subGenres.length,
                  itemBuilder: (context,index){
                    return sideButton(
                        isSelected: currentSubGenre == subGenres[index],
                        subGenres[index],
                        onPressed: (){
                          setState(() {
                            currentSubGenre = subGenres[index];
                            
                          });
                    });
                  }),
            ),
           page(context,widget.currentGenre,currentSubGenre)
          ],
      ),
    );
  }
}

Widget page(BuildContext context,String currentGenre, String currentSubGenre) {
  return  Expanded(
    child:paginatedView(
        key: Key(currentGenre+currentSubGenre),
        emptyText: "No Books Yet in ${currentGenre} Section",
        query:
        currentSubGenre=="All"? FirebaseFirestore.instance.collection("library").where("category",isEqualTo: currentGenre).where("status",isEqualTo: Status.Publish.name)
            // :currentSubGenre=="Hot"?FirebaseFirestore.instance.collection("library").where("category",isEqualTo: currentGenre).where("status",isEqualTo: Status.Publish.name).orderBy("seen",descending: true)
            :currentSubGenre=="Latest"?FirebaseFirestore.instance.collection("library").where("category",isEqualTo: currentGenre).where("status",isEqualTo: Status.Publish.name).orderBy("createdAt",descending: true)
            :FirebaseFirestore.instance.collection("library").where("category",isEqualTo: currentGenre.toCapitalized).where("subCategory",arrayContains: currentSubGenre.toCapitalized).where("status",isEqualTo: Status.Publish.name)

        ,//.where("genre",isEqualTo: widget.currentGenre),
        child: (datas,index){

          Map<String,dynamic> json = datas[index].data() as Map<String,dynamic>;
          BookModel book = BookModel.fromJson(json);

          return BookListItem(
            book: book,
            onTap: (){
              goto(context, BookDetailScreen(bookId: book.bookId, book: book));
            },
            size: SMALLSIZE,


          );
        }),
  );
}


Widget sideButton(
    String title,
    {
      FontWeight fontWeight = FontWeight.w700,
      double size  = 8,
      bool isSelected = false,
      required void Function()? onPressed

    }
    ){
  return Row(
    children: [
      isSelected?
      Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Container(
          height: 10,
          width: 5,
          decoration:BoxDecoration(
            color: colorRed,

          ) ,
        ),
      )
          :SizedBox.shrink(),
      Expanded(
        child: TextButton(
            style: ButtonStyle(
                alignment: Alignment.centerLeft,
                foregroundColor: WidgetStatePropertyAll(
                    isSelected?Colors.black: Colors.black87
                ),
                textStyle:WidgetStatePropertyAll(
                  GoogleFonts.montserrat(
                      fontSize: size,
                      fontWeight: FontWeight.w700
                  ),

                )
            ),


            onPressed:onPressed, child: Text(title,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(

          ),)),
      ),
    ],
  );
}

Widget tabButton(
    String title,
    {
      FontWeight fontWeight = FontWeight.w700,
      Color color = Colors.black,
      double size  = 8,
      bool isSelected = false,
      required void Function()? onPressed

    }
    ){
  return TextButton(
      style: ButtonStyle(
          alignment: Alignment.centerLeft,
          foregroundColor: WidgetStatePropertyAll(
              isSelected?Colors.purple.shade900: color
          ),
          textStyle:WidgetStatePropertyAll(
            TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: size,
                fontWeight: FontWeight.w700
            ),

          )
      ),


      onPressed:onPressed, child: Text(title,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.merriweather(
      fontWeight: FontWeight.w800,
      fontSize: 13

    ),));
}


extension StringCasingExtension on String {
  String get toCapitalized => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}