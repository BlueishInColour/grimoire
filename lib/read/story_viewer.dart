import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart' hide MarkdownWidget;
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/publish/rewrite_edit_screen.dart';
import 'package:grimoire/read/story_viewer_ui_controller.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:provider/provider.dart';
import '../commons/adapters/story_screen_adapter.dart';
import '../commons/ads/ads_helper.dart';
import '../commons/ads/ads_view.dart';
import '../commons/views/dictionary_view.dart';

import 'package:markdown_widget/markdown_widget.dart';

import '../main.dart';
class StoryViewer extends StatefulWidget {
  const StoryViewer({super.key,required this.story});
  final StoryModel story;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}


class _StoryViewerState extends State<StoryViewer> {
  String selectedText = "";
@override
void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

}

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryViewerUiController>(
      builder:(context,c,child){
        Color backgroundColor;
        Color textColor;
        double fontSize;

        switch (c.brightness) {
          case Brightness.Light:
            backgroundColor = Colors.white;
            textColor = Colors.black;
            break;
          case Brightness.Brown:
            backgroundColor = Color(0xFFF2DCB1);
            textColor= Colors.black;
            break;
          case Brightness.Dark:
          // Get system brightness setting
            backgroundColor = Colors.black;
            textColor= Colors.white;
            break;
        }

        switch(c.textSize){
          case TextSize.VerySmall:
            fontSize = 14; break;

          case TextSize.Small:
            fontSize = 16; break;

          case TextSize.Medium:
            fontSize = 18; break;

          case TextSize.Large:
            fontSize = 20; break;

          case TextSize.ExtraLarge:
            fontSize = 22; break;

        }

        return Scaffold(
          backgroundColor: backgroundColor,
          body: NestedScrollView(headerSliverBuilder: (context,_)=>[
            SliverAppBar(
              snap: true,
              pinned: false,
              floating: true,
              automaticallyImplyLeading: true,
              foregroundColor: textColor,
              actions: [
                if (widget.story.createdBy==FirebaseAuth.instance.currentUser?.email) IconButton(onPressed: (){
                  goto(context, RewriteEditScreen(bookId: widget.story.bookId, story: widget.story));
                }, icon: const Icon(Icons.edit_outlined,weight: 10,)) else SizedBox(),

                IconButton(onPressed: (){
                  if(c.brightness == Brightness.Light){c.brightness = Brightness.Dark;}
                 else if(c.brightness == Brightness.Brown){c.brightness = Brightness.Light;}
                else  if(c.brightness == Brightness.Dark){c.brightness = Brightness.Brown;}
                }, icon: Icon(Icons.brightness_5_sharp)),
                IconButton(onPressed: (){
                  if(c.textSize == TextSize.VerySmall){c.textSize = TextSize.Small;}
                  else if(c.textSize == TextSize.Small){c.textSize = TextSize.Medium;}
                  else if(c.textSize == TextSize.Medium){c.textSize = TextSize.Large;}
                  else if(c.textSize == TextSize.Large){c.textSize = TextSize.ExtraLarge;}
                  else if(c.textSize == TextSize.ExtraLarge){c.textSize = TextSize.VerySmall;}

                }, icon: Icon(Icons.text_increase)),
                IconButton(
                    onPressed: ()async{showModalBottomSheet(context: context, builder:(context)=>
                        DictionaryView(autoFocus:false,searchText:selectedText.isNotEmpty?selectedText:"select a text first!",));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            SliverAppBar(
              floating: false,
              pinned: false,
              automaticallyImplyLeading: false,
              title: Text(widget.story.title,style: GoogleFonts.merriweather(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w800,

              ),),
            ),
            widget.story.storyCoverImageUrl.isNotEmpty?SliverAppBar(
                toolbarHeight: 200,

                pinned:false,
                floating: false,
                snap: false, centerTitle: true,
                backgroundColor: Colors.transparent,


                automaticallyImplyLeading: false,

                title: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.story.storyCoverImageUrl,
                    fit: BoxFit.fill,))):SliverToBoxAdapter(),

          ],
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child:

                Markdown(
                    selectable: true,
                    softLineBreak: true,
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
                    styleSheet: MarkdownStyleSheet(
                        p : GoogleFonts.merriweather(
                          color: textColor,
                          fontSize:  fontSize
                        )
                    ),


                    data: widget.story.content,
                    onSelectionChanged:(text,textSelection,onChangeCause) {
                      setState(() {
                        selectedText=textSelection.textInside(text??"") ??"";
                        debugPrint(selectedText);
                      });
                    } ),
              )),
          bottomNavigationBar: adaptiveAdsView(
              AdHelper.getAdmobAdId(adsName:Ads.addUnitId1)

          ),

        );
      },
    );
  }
}