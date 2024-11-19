import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:free_english_dictionary/free_english_dictionary.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ads/ads_helper.dart';
import '../ads/ads_view.dart';
import 'bottom.dart';
import 'load_widget.dart';
import '../../main.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key,this.showSearchBar =true,this.autoFocus = true, this.searchText="grimoire"});
  final String searchText;
final bool autoFocus;
final bool showSearchBar;
  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  String searchText = "";
  final textController = TextEditingController();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      textController.text = widget.searchText;
      searchText = widget.searchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future:  FreeDictionary.getWordMeaning(word: searchText),
                builder: (context, snapshot) {
                  if(snapshot.connectionState ==ConnectionState.waiting)return loadWidget(color:Colors.black);
                  else if(snapshot.hasData){
                    List<WordMeaning> searchResults = snapshot.data??[];
                    return Scaffold(
                      body : ListView.separated(
                        itemCount: searchResults.length,
                        itemBuilder: (context,index){
                          WordMeaning meaning = searchResults[index];
                          return meaningPod(meaning:meaning,index: index);
                        },
                          separatorBuilder:(context,index){
                          return Divider(
                            color: Colors.grey[700],
                          );
                        }
                      )
                    );


                  }
                  else {return Image.asset("assets/empty.png");}
                }
              ),

            ),
          ),
         widget.showSearchBar? BottomBar(
            child:(fontSize,iconSize)=> TextField(
              controller: textController,
              onChanged: (v) {
                setState(() {
                  searchText = v;
                });
              },

              style: GoogleFonts.merriweather(
                  fontSize: fontSize,
                  color: Colors.white70
              ),


              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: (v){
                goto(context, DictionaryView(searchText: v,));
              },



              cursorHeight: 17,
              cursorColor: Colors.white,


              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20),
                  hintText: "search or ask the librarian ...",
                  hintStyle: GoogleFonts.merriweather(
                      fontSize: fontSize,
                      color: Colors.white70
                  ),
                  filled: true,

                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: (){
                          goto(context, MainApp());
                        },
                        icon: Icon(EneftyIcons.home_2_outline,color: Colors.white70,size: iconSize,)),
                  ),

                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: (){
                        goto(context, DictionaryView(
                          searchText: textController.text,
                          autoFocus: widget.autoFocus,));

                      },
                      icon: Icon(Icons.search,
                        color: Colors.white70,
                        size: iconSize,
                      ),
                    ),
                  )

              ),
            ),
          ):SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: adaptiveAdsView(
          AdHelper.getAdmobAdId(adsName:Ads.addUnitId6)

      ),
    );
  }
}

Widget meaningPod({required WordMeaning meaning,int index = 0}) {
  TextStyle titleStyle = GoogleFonts.merriweather(
    fontSize: 20,
    fontWeight: FontWeight.w700,

  );
  TextStyle disStyle = GoogleFonts.merriweather(
    fontWeight: FontWeight.w300,
    fontSize: 14
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      //phonetics
      Text(      meaning.phonetic??"",style: titleStyle,),
//word
    Text( "${(index+1).toString()}.   "+"${   meaning.word??" "}",style: titleStyle,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: meaning.meanings?.map((Meaning v){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //definitions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Definition",style: titleStyle,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: v.definitions?.map((v){
                    return  Text(v.definition??"",style: disStyle,);
                  }).toList() ??[],
                ),

                //synonyms
                v.synonyms != null&&v.synonyms!.isNotEmpty? Text("synonyms",style: titleStyle):SizedBox.shrink(),
                Wrap(children: v.synonyms?.map((v){return Text(v+", ",style: disStyle);}).toList() ??[],),
                SizedBox(height: 20,),

                //antonyms
                v.synonyms != null&& v.antonyms!.isNotEmpty? Text("antonyms",style: titleStyle):SizedBox.shrink(),
                Wrap(children: v.antonyms?.map((v){return Text(v+", ",style: disStyle);}).toList() ??[],),
                SizedBox(height: 20,),

              ],
              //

            ),
          ],
        );
      }).toList() ??[],
    )

    //meaning

    ],
  );
}
