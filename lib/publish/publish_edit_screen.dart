import 'package:flutter/material.dart';
import 'package:grimoire/load_widget.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:provider/provider.dart';

import '../CONSTANT.dart';

class PublishEditScreen extends StatefulWidget {
  const PublishEditScreen({super.key});

  @override
  State<PublishEditScreen> createState() => _PublishEditScreenState();
}

class _PublishEditScreenState extends State<PublishEditScreen> {
  final titleController = TextEditingController();
  final aboutBookController = TextEditingController();
 final tagsController = TextEditingController();
  final buttonStyle =ButtonStyle(
      alignment:Alignment.centerLeft,
      textStyle: WidgetStatePropertyAll(TextStyle(
          overflow: TextOverflow.ellipsis
      )),
      padding: WidgetStatePropertyAll(
          EdgeInsets.all(10)
      ),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ));

  @override
  Widget build(BuildContext context) {
    return Consumer<PublishController>(
      builder:(context,c,child)=> Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              //select book
              OutlinedButton.icon(

                
                style: buttonStyle,
                onPressed: (){c.chooseBook();},
                icon: Icon(Icons.file_copy_outlined),
                label: Text(c.bookFilePath,
                maxLines: 2,


                ),),

              SizedBox(height: 10,),
              //select/choose book cover
              OutlinedButton.icon(
                style: buttonStyle,

                onPressed: (){c.chooseBookCoverPhoto();},
                icon: Icon(Icons.image_outlined),
                label: Text(c.bookCoverPhotoPath),),

              SizedBox(height: 10,),

              //title
              TextField(
                controller: titleController,
                onChanged: (v) {c.title = v;},
                decoration: InputDecoration(
                  hintText: "title ...",

                ),
              ),

              //descriptions
              SizedBox(height: 10,),


              TextField(
                controller: aboutBookController,
                onChanged: (v){c.aboutBook  = v;},
                minLines: 2,
                maxLines: 100,
                decoration: InputDecoration(
                    labelText: "about book ..."
                ),
              ),

              SizedBox(height: 20,),

              //choose category
              DropdownMenu(
                label: Text("choose Genre"),
                width: 400,
                onSelected: (v){c.category = v;},
                enableSearch: true,

                dropdownMenuEntries: categories.map((v){
                  return DropdownMenuEntry(value: v, label: v,);
                }).toList(),
              ),
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
                  width: 400,
                 enableSearch: true,

                  dropdownMenuEntries: languages.map((v){
                    return DropdownMenuEntry(value: v, label: v);
                  }).toList(),
              ),
              SizedBox(height: 10,),

              //[privacy]
              TextButton.icon(
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft
                  ),
                  onPressed: (){c.private != c.private;},
                  icon   :  Checkbox(value: c.private,
                      onChanged: (v){c.private = v;}),
                  label: Text("save to private") ),

              SizedBox(height: 10,),

              //allow hard copy printing and sales
              TextButton.icon(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft
                ),
                  onPressed: (){c.approveHardcopyPublishing != c.approveHardcopyPublishing;},
                  icon   :  Checkbox(value: c.approveHardcopyPublishing,
                      onChanged: (v){c.approveHardcopyPublishing = v;}),
              label: Text("approve hard copy distribution") ),



              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){c.publishBook(context);}, child: Text("Publish"))
            ],
          ),
        )
      ),
    );
  }
}
