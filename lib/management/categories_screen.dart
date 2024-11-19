import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:typesense/typesense.dart';

import '../models/genre_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: categories.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: categories.map((v){return Tab(text: v);}).toList()),
      body: TabBarView(
          controller: tabController,
          children: categories.map((v){
        return EachCategoryScreen(key: Key(v),currentGenre:v);
      }).toList()),
    );
  }
}

class EachCategoryScreen extends StatefulWidget {
  const EachCategoryScreen({super.key, required this.currentGenre});
  final String currentGenre;


  @override
  State<EachCategoryScreen> createState() => _EachCategoryScreenState();
}

class _EachCategoryScreenState extends State<EachCategoryScreen> {

  final textController = TextEditingController();
createGenre()async{
  var ref =await FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).get();
  if(!ref.exists && ref.data() == null){
    await FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).set(
      GenreModel(title: widget.currentGenre,subGenres: []).toJson()
    ).whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${widget.currentGenre} created")));


    });
  }
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createGenre();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
          decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
            hintText: "Enter new sub category",
            suffixIcon: IconButton(onPressed: ()async{
            await  FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).update(
                  {"subGenres":FieldValue.arrayUnion([textController.text])

                  }).whenComplete((){
                    textController.clear();
            });
            }, icon: Icon(Icons.upload))

          ),
        ),
      ),
      body:
      StreamBuilder(
            stream: FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)return loadWidget();
              if(snapshot.hasData && snapshot.data?.data() != null ){
                Map<String,dynamic> data = snapshot.data?.data() ??{};
    GenreModel genreModel = GenreModel.fromJson(data);
             return    ListView.builder(
    itemCount: genreModel.subGenres.length,
    itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Long press to delete")));
                    },
                    onLongPress: ()async{
                      await FirebaseFirestore.instance.collection("genre").doc(widget.currentGenre).update(
                          {
                            "subGenres":FieldValue.arrayRemove([genreModel.subGenres[index]])
                          }).whenComplete((){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("deleted")));

                      });
                    },
                  title: Text(genreModel.subGenres[index],style: GoogleFonts.merriweather(),),
    );
    });

            }
              else return Image.asset("assets/empty.png");
            }
      )

    );
  }
}

