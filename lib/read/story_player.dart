import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/book_list_item.dart';
import 'package:grimoire/commons/views/dictionary_view.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/constant/CONSTANT.dart';
import 'package:grimoire/home_books/book_detail_screen.dart';
import 'package:grimoire/models/book_model.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/read/story_viewer_ui_controller.dart';
import 'package:provider/provider.dart';

class StoryPlayer extends StatefulWidget {
  const StoryPlayer({super.key,required this.bookId,required this.story,
    this.totalCount = 1,
    required this.book
  });
final String bookId;
final StoryModel story;
final BookModel book;
final int totalCount ;
  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
  int selectedStoryIndex = 0;

int currentWordStart =0;
int currentWordEnd =0;
String _currentWord= "";
  int end = 0;


  FlutterTts flutterTts = FlutterTts();
  TTsState ttsState = TTsState.Stopped;

  List<dynamic> voices =[];
  dynamic currentVoice ;


// Future fetchStories()async{
//   var res = await  FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: widget.bookId).orderBy("createdAt").get();
//   if(res.docs.isNotEmpty){
//     List<StoryModel> stories  = res.docs.map((v){
//       return StoryModel.fromJson(v.data());
//     }).toList() ?? [];
//     setState(() {
//       this.stories = stories;
//     });
//   }
//
// }
  Future _speak({required String text }) async{
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TTsState.Playing);
  }

  Future _stop() async{
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TTsState.Stopped);
  }
Future _pause()async{
var result =   await flutterTts.pause();
if (result == 1) setState(() => ttsState = TTsState.Paused);


}
  // List<dynamic> languages = await flutterTts.getLanguages;

setLanguage({String language ="en-US"})async{
  await flutterTts.setLanguage(language);

}
  setSpeechRate({double speechRate = 0.6})async{
    debugPrint(speechRate.toString());
    await flutterTts.setSpeechRate(speechRate);

    Provider.of<StoryViewerUiController>(context,listen: false).speechRate = speechRate;

  }
  setPitch({double pitch = 0.4})async{
    await flutterTts.setPitch(pitch);
    Provider.of<StoryViewerUiController>(context,listen: false).pitch = pitch;

  }

  setVolume({double volume = 0.5})async{
    await flutterTts.setVolume(volume);

    Provider.of<StoryViewerUiController>(context,listen: false).volume = volume;

  }



// iOS, macOS, and Android only
// The last parameter is an optional boolean value for isFullPath (defaults to false)

  handler()async{

    if (Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TTsState.Playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TTsState.Stopped;
      });
    });

    flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
      setState(() {
        _currentWord =  word;
        end = endOffset;
        currentWordStart = startOffset;
        currentWordEnd = endOffset;

      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TTsState.Stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TTsState.Stopped;
      });
    });

// Android, iOS and Web
    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TTsState.Paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TTsState.Continue;
      });
    });}

  Future<dynamic> _getVoices()async{

    voices = await flutterTts.getVoices;
    voices = voices.where((voice) => voice['name'].contains('en')).toList();
    setState(() {
      this.voices = voices;
      currentVoice = voices.first;

    });
    flutterTts.setVoice(currentVoice);
  }
  changeVoice(dynamic voice){
    flutterTts.setVoice(voice);
    setState(() {
      currentVoice = voice;
    });

  }

    Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

    Future<dynamic> _getEngines() async => await flutterTts.getEngines;

    Future<void> _getDefaultEngine() async {
      var engine = await flutterTts.getDefaultEngine;
      if (engine != null) {
        print(engine);
      }
    }

    Future<void> _getDefaultVoice() async {
      var voice = await flutterTts.getDefaultVoice;
      if (voice != null) {
        print(voice);
      }}
Future<void> _downloadAudioBook()async{
   dynamic v=    await flutterTts.synthesizeToFile(widget.story.content, widget.story.title);
        showToast(v);
}
  showSettings(
      context
      ){
      _pause();
      showModalBottomSheet(context: context,
          builder: (context){
        return Consumer<StoryViewerUiController>(
          builder:(context,c,child){
            Widget verticalSlide({
              required double value,
                required  Function(double)? onChanged,
              double width=59,
              double height = 300,
              bool isVertical = true,
            }){
             return  Stack(
               children: [
                 SizedBox(
                   height: isVertical?height:width,
                   width:isVertical? width:height,
                   child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: width,
                        thumbColor: Colors.transparent,
                        overlayShape: SliderComponentShape.noOverlay,
                        thumbShape: RoundSliderThumbShape(elevation: 0,disabledThumbRadius: 0,enabledThumbRadius: 0,pressedElevation: 9),
                        trackShape: RectangularSliderTrackShape()
                        // ,
                      ),
                      child: RotatedBox(
                          quarterTurns:isVertical? 3:0,
                          child:
                          Slider(
                              activeColor: colorRed,
                              inactiveColor: Colors.red.shade200,
                              value:value,
                              onChanged:onChanged
                          )
                      ),),
                 ),
                 Positioned(
                     top:0,
                     right: 0,
                     left: 0,
                     child: Icon(Icons.access_time_filled)
                 ),
                 Positioned(
                     top: 0,
                     bottom: 0,
                     right: 0,
                     left: 0,
                     child: Center(child: Text((value*100).round().toString()),)),
                 Positioned(
                 bottom:  0,
                     left: 0,
                     right: 0,
                     child: Icon(Icons.add_business)
                 )
               ],
             );
            }
            Widget horizontalSlide(
                String title,
                {
              required double value,
              required  Function(double)? onChanged,
              double width=59,
              double height = 300,
              IconData startIcon =Icons.access_time_filled,
              IconData endIcon =Icons.access_time_filled,
            }){
              return  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.white60
                    ),),
                    SizedBox(height: 5,),
                    Stack(
                      children: [
                        SizedBox(
                          child: SliderTheme(
                            data: SliderThemeData(
                                trackHeight: width,
                                thumbColor: Colors.transparent,
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbShape: RoundSliderThumbShape(elevation: 0,disabledThumbRadius: 0,enabledThumbRadius: 0,pressedElevation: 9),
                                trackShape: RoundedRectSliderTrackShape(),
                              rangeTrackShape: RoundedRectRangeSliderTrackShape()
                              // ,
                            ),
                            child: RotatedBox(
                                quarterTurns:0,
                                child:
                                Slider(
                                    activeColor: colorRed,
                                    inactiveColor: Colors.red.shade200,
                                    value:value,
                                    onChanged:onChanged
                                )
                            ),),
                        ),
                        // Positioned(
                        //     top:0,
                        //     bottom: 0,
                        //     left: 5,
                        //     child: Icon(startIcon)
                        // ),
                        Positioned(
                            top:0,
                            bottom: 0,
                            left: 15,
                            child: Center(child: Text((value*100).round().toString() +"%",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,

                            ),),)),
                        // Positioned(
                        //     bottom: 0,
                        //     top: 0,
                        //     right: 5,
                        //     child: Icon(endIcon)
                        // )
                      ],
                    ),
                  ],
                ),
              );
            }
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(onPressed: (){Navigator.pop(context);},
                    icon: Icon(Icons.clear,color: Colors.black,)),
              ),
              body: ListView(
                children: [

                  horizontalSlide("Speech Rate",value: c.speechRate, onChanged: (v)=> setSpeechRate(speechRate: v)),
                  horizontalSlide("Pitch",value: c.pitch, onChanged: (v)=>setPitch(pitch: v),),
                  horizontalSlide("Volume",value: c.volume, onChanged:(v)=>setVolume(volume: v),startIcon: Icons.volume_down_rounded,endIcon: Icons.volume_up_rounded),

                  ListTile(
                    title: Text("Voices",style: GoogleFonts.montserrat( fontWeight: FontWeight.w700,
                        color: Colors.white60),),
                    trailing: Text(currentVoice.toString(),
                    style: TextStyle(color: Colors.white70),),
                  )
                ],
              ),
            );
          },
        );
      });
  }
  List<TextSpan> _buildTextSpans(String text) {
    List<TextSpan> spans = [];
    if (currentWordStart != null && currentWordEnd != null) {
      spans.add(
        TextSpan(
          text: text.substring(0, currentWordStart),
          style: TextStyle(color: Colors.black87),
        ),
      );
      spans.add(
        TextSpan(
          text: text.substring(currentWordStart, currentWordEnd),
          style: TextStyle(color: Colors.black87, backgroundColor: Colors.blue),
        ),
      );
      spans.add(
        TextSpan(
          text: text.substring(currentWordEnd),
          style: TextStyle(color: Colors.black87),
        ),
      );
    } else {
      spans.add(TextSpan(text: text, style: TextStyle(color: Colors.black87)));
    }
    return spans;
  }

  getAudio()async
  {
  await  flutterTts.awaitSynthCompletion(true);
    await flutterTts.synthesizeToFile(widget.story.content, widget.story.title+".wav");

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVoices();
    // fetchStories();
    handler();
    setState(() {
    });
getAudio();

  }
  @override
  Widget build(BuildContext context) {
    StoryModel currentStory =widget.story;

    return
    currentStory.content.isEmpty?
        loadWidget(color: colorRed)
        :
    Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context); }, icon: Icon(Icons.clear)),
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child:

            Column(
              children: [
                image(context,widget.book.bookCoverImageUrl , 40),
                SizedBox(height: 10,),
                Text(widget.book.title,
                  style: GoogleFonts.merriweather(
                      fontSize: 15,
                      color: Colors.black45,
                      fontWeight: FontWeight.w800
                  ),),
                Text("Chapter ${widget.story.chapterIndex}",
                  style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    color: Colors.black54
                  ),),
                Text(currentStory.title,
                  style: GoogleFonts.merriweather(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w800
                  ),),
                SizedBox(height: 60,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(color: colorRed,width: 7,height: 40,),
                    SizedBox(width: 2,),
                    Text("Read Along",
                      style: GoogleFonts.crimsonText(
                          fontWeight: FontWeight.w800,
                          fontSize: 25
                      ),),
                  ],),

                Text.rich(
                  TextSpan(
                  children: _buildTextSpans(currentStory.content),
                    style:  GoogleFonts.merriweather(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87
                    ),
                  )
                ,
                  style: GoogleFonts.merriweather(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    color: Colors.black87
                  ),),

                //

              ],
            )
          ),

        ],
      ),
      bottomNavigationBar:  SizedBox(
        height: 200,
        child: Column(
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.red.shade200,
              color: colorRed,

              value:currentStory.content.isEmpty?0: end /  currentStory.content.length,
            ),
            SizedBox(height: 10,),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {showSettings(context);},
                      icon: Icon(Icons.settings, size: 20,
                      color: Colors.black54,)),
                  // IconButton(
                  //     onPressed: () {
                  //
                  //       if(selectedStoryIndex>0) {
                  //         setState(() {
                  //           selectedStoryIndex -= 1;
                  //         });
                  //         _pause();
                  //
                  //       }
                  //     },
                  //     icon: Icon(Icons.arrow_back_ios,
                  //         color: selectedStoryIndex>0?Colors.black:Colors.black54,
                  //
                  //         size: 35)),
                  IconButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(CircleBorder()),
                      backgroundColor: WidgetStatePropertyAll(colorRed),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),

                      onPressed: () {
                        ttsState == TTsState.Playing?
                        _pause():
                        _speak(
                            text:currentStory.content
                        );
                      },
                      icon: Icon(
                        ttsState == TTsState.Playing? Icons.pause:Icons.play_arrow_rounded,
                        size: 50,
                      )),
                  // IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         if(selectedStoryIndex<stories.length-1) {
                  //           selectedStoryIndex += 1;
                  //           _pause();
                  //
                  //         }
                  //       }
                  //
                  //       );
                  //     },
                  //     icon: Icon(
                  //       Icons.arrow_forward_ios,
                  //       color: selectedStoryIndex>=stories.length-1?Colors.black54:Colors.black,
                  //       size: 35,
                  //     )),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(context: context, builder:
                        (context){
                        return  DictionaryView(
                          searchText: _currentWord,
                          autoFocus: false,
                          showSearchBar: true,
                        );
                        });

                      },
                      icon: Icon(
                        Icons.search,
                        size: 20,
                          color: Colors.black54
                      )),
                ],
              ),

            ),

          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}

enum TTsState{
  Playing,
  Stopped,
  Continue,
  Paused
}