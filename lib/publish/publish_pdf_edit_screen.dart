import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:provider/provider.dart';

import '../constant/CONSTANT.dart';
import '../commons/views/book_list_item.dart';
import '../models/book_model.dart';

class PublishPdfEditScreen extends StatefulWidget {
  const PublishPdfEditScreen({super.key});

  @override
  State<PublishPdfEditScreen> createState() => _PublishPdfEditScreenState();
}

class _PublishPdfEditScreenState extends State<PublishPdfEditScreen> {
  Color filledColor = Colors.white70;
  final titleController = TextEditingController();
  final aboutBookController = TextEditingController();
 final tagsController = TextEditingController();
  final buttonStyle =ButtonStyle(
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

      backgroundColor: WidgetStatePropertyAll(Colors.white70),
      foregroundColor: WidgetStatePropertyAll(Colors.black87
      )
  );

  @override
  Widget build(BuildContext context) {
    final double size = 15;
    return Consumer<PublishController>(
      builder:(context,c,child)=> Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
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
                        TextField(
                          minLines: 4,
                        maxLines: 4,
                          controller: titleController,
                          onChanged: (v) {c.title = v;},
                          decoration: InputDecoration(
                            hintText: "title ...",
                            fillColor: Colors.white70

                          ),),


                          SizedBox(height: 10,),
                          //select/choose book cover
                          ElevatedButton.icon(
                            style: buttonStyle,

                            onPressed: (){c.chooseBookCoverPhoto(context);},
                            icon: Icon(Icons.image_outlined),
                            label: Text(c.bookCoverPhotoPath),),
                        SizedBox(height: 10,),
                        //select book
                        ElevatedButton.icon(


                          style: buttonStyle,
                          onPressed: (){c.chooseBook(context);},
                          icon: Icon(Icons.file_copy_outlined),
                          label: Text(c.bookFilePath,
                            maxLines: 2,


                          ),),
                          SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),


              //title


              //descriptions
              SizedBox(height: 10,),


              TextField(
                controller: aboutBookController,
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
                    ElevatedButton.icon(
                        onPressed: (){c.removeFromTag(v);},
                        icon: Icon(Icons.clear),
                    label: Text(v));}).toList(),
                  ),
                ],
              ),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  hintText: "tags"

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

              //[privacy]
              TextButton.icon(
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: (){
                    if(c.status == Status.Private) c.status = Status.Drafted;
                      else c.status = Status.Private;
                    ;},
                  icon   :  Checkbox(value: c.status == Status.Private,
                      onChanged: (v){

                        if(c.status == Status.Private) c.status = Status.Drafted;
                        else c.status = Status.Private;
                  }),
                  label: Text("save to private") ),

              SizedBox(height: 10,),

              //allow hard copy printing and sales
              TextButton.icon(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft
                ),
                  onPressed: (){c.approveHardcopyPublishing = !c.approveHardcopyPublishing;},
                  icon   :  Checkbox(value: c.approveHardcopyPublishing,
                      onChanged: (v){c.approveHardcopyPublishing = v;}),
              label: Text("approve hard copy distribution") ),



              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                // c.publishBook(context);
                }
                  , child: Text("Publish"))
            ],
          ),
        )
      ),
    );
  }
}


