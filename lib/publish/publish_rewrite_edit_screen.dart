import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:provider/provider.dart';
import '../constant/CONSTANT.dart';
import '../chat/chat_screen.dart';
import '../commons/views/book_list_item.dart';
import '../models/book_model.dart';
import '../repository/book_repository.dart';

class PublishRewriteEditScreen extends StatefulWidget {
  const PublishRewriteEditScreen({super.key,required this.book});
  final BookModel book;

  @override
  State<PublishRewriteEditScreen> createState() => _PublishRewriteEditScreenState();
}

class _PublishRewriteEditScreenState extends State<PublishRewriteEditScreen> {
  Color filledColor = Colors.white;
  final titleController = TextEditingController();
  final aboutBookController = TextEditingController();
  final tagsController = TextEditingController();
  buttonStyle ()=>ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(400,50)),
      alignment:Alignment.centerLeft,
      textStyle: WidgetStatePropertyAll(TextStyle(
          overflow: TextOverflow.ellipsis
      )),
      padding: WidgetStatePropertyAll(
          EdgeInsets.all(10)
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
        ),


      ),

      backgroundColor: WidgetStatePropertyAll(filledColor),
      foregroundColor: WidgetStatePropertyAll(Colors.black87
      )
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PublishController>(context, listen: false).bookModel = widget.book;
      titleController.text = widget.book.title;
      aboutBookController.text =widget.book.aboutBook;

    });
  }
  @override
  Widget build(BuildContext context) {
    final double size = 10;
    return Consumer<PublishController>(
      builder:(context,c,child)=> Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            title:Text("Edit"),

            actions: [
              TextButton(onPressed: (){
                BookRepository().createBook(context, book: c.bookModel, bookId: widget.book.bookId,
                    whenCompleted: (){Navigator.pop(context);});
              },
                  child: Text("Save"))
            ],
          ),


          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image(context,c.bookCoverImageUrl,size),

                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(height: 10,),
                          //select/choose book cover
                          TextButton.icon(
                            onPressed: (){c.chooseBookCoverPhoto(context);},
                            icon: Icon(Icons.image_outlined),
                            label: Text(c.bookCoverPhotoPath),),
                          SizedBox(height: 10,),
                          TextButton.icon(
                              icon: Icon(Icons.color_lens_outlined),
                              onPressed: (){
                                goto(context, ChatScreen(
                                  email: "blueishincolor@gmail.com",
                                  messageText:"Yo! I need a professional Book Cover for my book, Let's chat!",

                                  showMessageBar: true,));
                              },
                              label: Text("Get Professional Book Cover Art")),
                          //select book
                        ],
                      ),
                    ),
                  ],
                ),


                //title


                //descriptions
                SizedBox(height: 10,),
                TextField(
                  controller: titleController,
                  style: GoogleFonts.merriweather(),
                  onChanged: (v) {c.title = v;},
                  decoration: InputDecoration(
                      labelText: "title ...",
                      fillColor: Colors.white70

                  ),),

                SizedBox(height: 10,),

                TextField(
                  controller: aboutBookController,
                  style: GoogleFonts.merriweather(),

                  onChanged: (v){c.aboutBook  = v;},
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: filledColor,
                      labelText: "about book ..."
                  ),

                ),

                SizedBox(height: 20,),

                //choose category
                DropdownMenu(
                  label: Text("choose Genre"),

                  width: MediaQuery.of(context).size.width,
                  inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: filledColor
                  ),
                  onSelected: (v){c.category = v;},
                  enableSearch: true,

                  dropdownMenuEntries: categories.map((v){
                    return DropdownMenuEntry(value: v, label: v,);
                  }).toList(),
                ),
                SizedBox(height: 15,),
                //tags
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Wrap(
                      children: c.tags.map((v){return
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  elevation: WidgetStatePropertyAll(0),
                                  backgroundColor : WidgetStatePropertyAll(Colors.grey[100])
                                  ,foregroundColor : WidgetStatePropertyAll(Colors.black87)
                              ),
                              onPressed: (){c.removeFromTag(v);},
                              label: Icon(Icons.clear),
                              icon: Text("#"+v)),
                        );}).toList(),
                    ),
                  ],
                ),
                TextField(
                  controller: tagsController,
                  style: GoogleFonts.merriweather(),

                  decoration: InputDecoration(
                      hintText: "tags",

                      filled: true,
                      fillColor: filledColor

                      ,
                      suffixIcon: IconButton(
                        onPressed: (){
                          c.addToTag(tagsController.text);
                          tagsController.clear();
                        },
                        icon: Icon(Icons.add  ),
                      )),
                ),

                //chose language
                SizedBox(height: 20,),
                DropdownMenu(
                  onSelected: (v){c.language = v;},

                  label: Text("choose language"),
                  width: MediaQuery.of(context).size.width,

                  enableSearch: true,
                  inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: filledColor
                  ),

                  dropdownMenuEntries: languages.map((v){
                    return DropdownMenuEntry(value: v, label: v);
                  }).toList(),
                ),
                SizedBox(height: 20,),
                DropdownMenu(
                  label: Text("Status"),

                  width: MediaQuery.of(context).size.width,
                  inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: filledColor
                  ),
                  onSelected: (v){c.status = v;},
                  enableSearch: true,

                  dropdownMenuEntries: [
                    Status.Drafted,
                    Status.Private,
                  Status.Review
                  ].map((v){
                    return DropdownMenuEntry(value: v, label:v==Status.Review?"Publish": v.name,);
                  }).toList(),
                ),

                //[privacy]

                SizedBox(height: 10,),

                //allow hard copy printing and sales
                TextButton.icon(
                    style: ButtonStyle(
                        alignment: Alignment.centerLeft
                    ),
                    onPressed: (){c.approveHardcopyPublishing = !c.approveHardcopyPublishing;},
                    icon   :  Checkbox(value: c.approveHardcopyPublishing,
                        onChanged: (v){c.approveHardcopyPublishing = v;}),
                    label: Text("Approve hard copy distribution") ),



                SizedBox(height: 20,),
              ],
            ),
          )
      ),
    );
  }
}


