import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/main.dart';
import 'package:grimoire/main_controller.dart';
import 'package:grimoire/publish/publish_controller.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:provider/provider.dart';
import '../commons/views/crop_image_screen.dart';
import '../constant/CONSTANT.dart';
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
  BookModel bookModel = BookModel();

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
    bookModel = widget.book;
    titleController.text = widget.book.title;
    aboutBookController.text =widget.book.aboutBook;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }
  @override
  Widget build(BuildContext context) {
    final double size = 10;

    return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            title:Text("Edit"),

            actions: [
              TextButton(onPressed: (){
                BookRepository().createBook(context, book: bookModel, bookId: widget.book.bookId,
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
                    image(context,bookModel.bookCoverImageUrl,MIDDLESIZE),

                    SizedBox(width: 5,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(height: 10,),
                          //select/choose book cover
                          TextButton.icon(
                            onPressed: (){chooseBookCoverPhoto(context);},
                            icon: Icon(Icons.image_outlined),
                            label: Text("Choose Book Cover Picture"),),
                          SizedBox(height: 10,),
                          TextButton.icon(
                              icon: Icon(Icons.color_lens_outlined),
                              onPressed: ()async{
                              await  EasyLauncher.email(
                                    email: "blueishincolour@gmail.com",
                                    subject: "Request for Professional Book Cover Art");

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
                  // onChanged: (v) {c.title = v;},
                  decoration: InputDecoration(
                      labelText: "title ...",
                      fillColor: Colors.white70

                  ),),

                SizedBox(height: 10,),

                TextField(
                  controller: aboutBookController,
                  style: GoogleFonts.merriweather(),

                  // onChanged: (v){c.aboutBook  = v;},
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
                  label: Text(bookModel.category.isEmpty?"choose Genre":bookModel.category),


                  width: MediaQuery.of(context).size.width,
                  menuStyle: MenuStyle(


                      fixedSize: WidgetStatePropertyAll(Size(200,500)),
                      // maximumSize: WidgetStatePropertyAll(Size(200,500))
                  ),

                  inputDecorationTheme: InputDecorationTheme(
                    
                      filled: true,

                      fillColor: filledColor
                  ),
                  onSelected: (v){setState(() {

                    bookModel.category = v ??"??";
                  });},
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
                      children: bookModel.tags.map((v){return
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  elevation: WidgetStatePropertyAll(0),
                                  backgroundColor : WidgetStatePropertyAll(Colors.grey[100])
                                  ,foregroundColor : WidgetStatePropertyAll(Colors.black87)
                              ),
                              onPressed: (){
                                setState(() {
                                  bookModel.tags.remove(v);
                                });;},
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
                          bookModel.tags.add(tagsController.text);
                          tagsController.clear();
                        },
                        icon: Icon(Icons.add  ),
                      )),
                ),

                //chose language
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: filledColor
                  ),
                  child: LanguagePickerDropdown(


                    initialValue:Language.fromIsoCode(bookModel.languageIsoCode),
                    onValuePicked: (Language language) {
                      setState(() {
                        bookModel.language =language.name;
                        bookModel.languageIsoCode =language.isoCode;
                      });;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                DropdownMenu(
                  label: Text( bookModel.status.name.isEmpty? "Status":bookModel.status.name),

                  width: MediaQuery.of(context).size.width,
                  inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: filledColor
                  ),
                  onSelected: (v){setState(() {
                    bookModel.status = v ??Status.Drafted;
                  });;},
                  enableSearch: true,

                  dropdownMenuEntries: [
                    Status.Drafted,
                    Status.Private,
                  Status.Review,
                    Status.Scheduled
                  ].map((v){
                    return DropdownMenuEntry(value: v, label:v==Status.Review?"Publish": v.name,);
                  }).toList(),
                ),

                //[privacy]
                SizedBox(height: 20,),
              ],
            ),
          )
    );}


  chooseBookCoverPhoto(BuildContext context)async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false

    );


    if (result != null) {
      File file = File(result.files.single.path!);
      var bookCoverPhotoPath = file.path;
      goto(context, CropImageScreen(ratio: Ratio(width: 9, height: 16),afterCropped: (image){
        MainController().uploadListOfMemoryImage(context, medias: [image],
            afterOneUpload: (v){
          setState(() {
            bookModel.bookCoverImageUrl = v;
          });},
            afterTotalUpload: (){Navigator.pop(context);},
            isFailed: (){showToast( "Failed to upload cropped image");});
      },));

    } else {
      // User canceled the picker
    }
  }



}


