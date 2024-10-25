import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/book_model.dart';
import 'package:grimoire/commons/book_grid_item.dart';
import 'package:grimoire/commons/book_list_item.dart';
import 'package:grimoire/commons/paginated_view.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/search_and_genre/genre_model.dart';
import 'package:provider/provider.dart';

class GenreIndexScreen extends StatefulWidget {
  const GenreIndexScreen({super.key});
  @override
  State<GenreIndexScreen> createState() => _GenreIndexScreenState();
}

class _GenreIndexScreenState extends State<GenreIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //sidebar
          Container(
            width: 85,
            child:
            Column(
              children: [
                ...["All","Hot","Latest"].map((v) {
                  return sideButton(v, isSelected: v == c.currentsubGenre,
                  onPressed: (){
                    // setState(() {
                      c.currentsubGenre = v;
                    // });
                  });
                }).toList(),

                FutureBuilder(
                    future: FirebaseFirestore.instance.collection("genre").doc(c.currentGenre).get(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState ==ConnectionState.waiting){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [

                            CupertinoActivityIndicator(color: Colors.black,),
                          ],
                        );
                      }
                      else if(snapshot.hasData) {
                        Map<String, dynamic> data = snapshot.data!.data() ??{};
                        GenreModel genre = GenreModel.fromJson(data);
                        return  Expanded(
                          child: ListView(
                            children: genre.subGenres.map((v) {
                              return sideButton(v, isSelected: v == c.currentsubGenre,onPressed: (){
                                // setState(() {
                                  c.currentsubGenre=v;
                                // });
                                debugPrint(c.currentsubGenre);
                              });
                            }).toList(),
                          ),
                        );
                      } else return SizedBox();
                    }
                ),


              ],
            ),

          ),

          //screen
          Expanded(
            child:
          paginatedView(
          query:
          c.currentsubGenre=="All"? FirebaseFirestore.instance.collection("library").where("genre",isEqualTo: c.currentGenre)
              :c.currentsubGenre=="Hot"?FirebaseFirestore.instance.collection("library").where("genre",isEqualTo: c.currentGenre).orderBy("seen",descending: true)
              :c.currentsubGenre=="Latest"?FirebaseFirestore.instance.collection("library").where("genre",isEqualTo: c.currentGenre).orderBy("createdAt",descending: true)
              :FirebaseFirestore.instance.collection("library").where("genre",isEqualTo: c.currentGenre).where("tags",arrayContains: c.currentsubGenre)

              ,//.where("genre",isEqualTo: widget.currentGenre),
      child: (json){
            BookModel book  = BookModel.fromJson(json);
            return BookListItem(onTap: (){}, id: 0,
            title: book.title,
                imageUrl: book.bookCoverImageUrl,
              aboutBook: book.aboutBook,
              bookUrl: book.bookUrl,
             );
      }))
        ],
      ),
    );
  }
}

Widget sideButton(
    String title,
    {
      FontWeight fontWeight = FontWeight.w700,
      Color color = Colors.black,
      double size  = 10,
      bool isSelected = false,
      required void Function()? onPressed

    }
    ){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      isSelected?  Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          radius: 3,
          backgroundColor: Colors.red.shade900,
        ),
      )
          :SizedBox.shrink(),
      TextButton(
          style: ButtonStyle(
              alignment: Alignment.centerLeft,
              foregroundColor: WidgetStatePropertyAll(
                  isSelected?Colors.purple.shade900: color
              ),
              textStyle:WidgetStatePropertyAll(
                GoogleFonts.montserrat(
                  // overflow: TextOverflow.ellipsis,
                    fontSize: size,
                    fontWeight: FontWeight.w700
                ),

              )
          ),


          onPressed:onPressed, child: Text(title)),
    ],
  );
}


List<ItemModel> list = [
  ItemModel(height: 100,sold: 20),
  ItemModel(height: 139),
  ItemModel(height: 144,sold: 32),
  ItemModel(height: 102,sold: 1),
  ItemModel(height: 144),
  ItemModel(height: 127,sold: 30),
  ItemModel(height: 186),
  ItemModel(height: 167),
  ItemModel(height: 122),
  ItemModel(height: 150),
  ItemModel(height: 0130),
  ItemModel(height: 292),
  ItemModel(height: 249),
  ItemModel(height: 149),
  ItemModel(height:144),
  ItemModel(height: 0130),
  ItemModel(height: 145),
  ItemModel(height: 499),
  ItemModel(height: 149),
  ItemModel(height: 222),
];


class ItemModel{
  ItemModel({
    this.id = 0,
    this.height= 100,
    this.title = "green hoodie with leather zip and belt and many other thingss",
    this.price = 200000,
    this.sold  = 0,
    this.imageUrl = "https://picsum.photos/200/300?random=2",
    this.store ="bukky store"

  });
  int id;
  String title;
  double price;
  double height;
  String imageUrl;
  int sold;
  String store;
}

