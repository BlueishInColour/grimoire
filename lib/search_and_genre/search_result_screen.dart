import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/dictionary_view.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:provider/provider.dart';
import '../commons/views/book_grid_item.dart';
import '../commons/views/bottom.dart';
import '../commons/views/load_widget.dart';
import '../commons/views/paginated_view.dart';
import '../main_controller.dart';
import '../models/book_model.dart';
import '../models/user.dart';
import '../repository/follow_repository.dart';
import '../repository/user_repository.dart';
import '../tablet/tablet_ui_controller.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key,this.isTablet =false,this.searchText =""});
final bool isTablet;
  final String searchText;
  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with TickerProviderStateMixin{

  late TabController tabController;
  String searchText = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    tabController = TabController(length: 3, vsync: this,initialIndex: 0);
    controller.text = widget.searchText;
    searchText = widget.searchText;
  }
  @override
  Widget build(BuildContext context) {
    // String searchText = widget.searchText;

    return Consumer<MainController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
          title:
          SearchBar(
            autoFocus: true,

            controller: controller,
            onChanged: (v){setState(() {
              searchText = v;
            });},

            hintText: "search",


            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            trailing:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: (){
                  },
                  icon: Icon(Icons.search,
                    color:searchText.isNotEmpty?colorRed: Colors.black54,
                  ),
                ),
              )
            ],


          ),
          bottom: TabBar(
            isScrollable: true,
              controller: tabController,

              tabs: [
            Tab(text: "Books",),
                Tab(text: "Writers",),
            Tab(text: "Dictionary",),
          ]),
        ),

        body:  Column(
          children: [
            Expanded(
              child:
                TabBarView(
                    controller: tabController,
                    children: [
                  paginatedView(
                    key:Key(searchText),
                      query: FirebaseFirestore.instance.collection('library').where(
                          'searchTags',
                          arrayContainsAny: searchText.split(' ')) ,
                    emptyText: "No result for $searchText",
                      child: (datas,index){
                        List<BookModel> books = datas.map((v){return BookModel.fromJson(v.data() as Map<String,dynamic>);}).toList();
                        BookModel book  = books[index];
                        return BookListItem(

                            size: 10,onTap: (){},
                            book: book);
                      }),


      StreamBuilder(stream: UserRepository().ref.where("pen_name",isNotEqualTo:searchText).orderBy("pen_name").startAt([searchText]).endAt([searchText+'\uf8ff',]).limit(20).get().asStream()
          , builder: (context,snapshot){

        if(snapshot.connectionState==ConnectionState.waiting)return loadWidget()       ;
        else if(snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty){
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index){
            User user = User.fromJson(snapshot.data?.docs[index].data() ??{});;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.profile_picture_url),
              ),
              title: Text("@"+user.pen_name),
              trailing:  CircleAvatar(
                backgroundColor: Colors.transparent,
                child: StreamBuilder<bool>(
                    stream: FollowRepository().isFollowing(user.email_address),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting)return Text("-",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),);
                      if(snapshot.hasData && snapshot.data ==true){
                        return  GestureDetector(
                            onTap: (){
                              FollowRepository().unFollowWriter(user.email_address);
                            },
                            child: Icon(Icons.done,color: colorBlue,)
                        );
                      }
                      else   return GestureDetector(
                        onTap: (){
                          FollowRepository().followWriter(user.email_address);
                
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person_add_alt_1_outlined,color: colorBlue,),
                          ],
                        ),);}),
              )
            );
          });
        }
        else return Image.asset("assets/empty.png");
      })

      ,
                  DictionaryView(
                    key: Key(searchText),
                    showSearchBar:false,
                    autoFocus: false,
                    searchText: searchText,
                  )
                ])
            ),

          ],
        ),


      ),
    );
  }
}
