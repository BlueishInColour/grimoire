import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grimoire/commons/views/dictionary_view.dart';
import 'package:grimoire/commons/views/load_widget.dart';
import 'package:grimoire/models/story_model.dart';
import 'package:grimoire/read/story_viewer_ui_controller.dart';
import 'package:provider/provider.dart';

class StoryPlayer extends StatefulWidget {
  const StoryPlayer({super.key,required this.bookId,this.stories =const[]
  });
final String bookId;
final List<StoryModel> stories;
  @override
  State<StoryPlayer> createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
List<StoryModel> stories  = [];
  int selectedStoryIndex = 0;
 StoryModel currentStory(){
    return stories[selectedStoryIndex];
  }

int currentWordStart =0;
int currentWordEnd =0;
String _currentWord= "";
  int end = 0;


  FlutterTts flutterTts = FlutterTts();
  TTsState ttsState = TTsState.Stopped;

  List<dynamic> voices =[];
  dynamic currentVoice ;


Future fetchStories()async{
  var res = await  FirebaseFirestore.instance.collection("story").where("bookId",isEqualTo: widget.bookId).orderBy("createdAt").get();
  if(res.docs.isNotEmpty){
    List<StoryModel> stories  = res.docs.map((v){
      return StoryModel.fromJson(v.data());
    }).toList() ?? [];
    setState(() {
      this.stories = stories;
    });
  }

}
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

  showSettings(
      context
      ){
      showModalBottomSheet(context: context, builder: (context){
        return Consumer<StoryViewerUiController>(
          builder:(context,c,child)=> Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                SizedBox(height: 10,),
                Text("Speech Rate"),
                Slider(

                    value: c.speechRate, onChanged:(v)=>setSpeechRate(speechRate: v)),

                Text("Pitch"),
                Slider(value: c.pitch, onChanged: (v)=>setPitch(pitch: v)),

                Text("Volume"),
                Slider(value: c.volume, onChanged:(v)=>setVolume(volume: v)),

                ListTile(
                  title: Text("Voices"),
                  trailing: Text(currentVoice.toString()),
                )

              ],
            ),
          ),
        );
      });
  }
  List<TextSpan> _buildTextSpans(String text) {
    List<TextSpan> spans = [];
    if (currentWordStart != null && currentWordEnd != null) {
      spans.add(
        TextSpan(
          text: text.substring(0, currentWordStart),
          style: TextStyle(color: Colors.black),
        ),
      );
      spans.add(
        TextSpan(
          text: text.substring(currentWordStart, currentWordEnd),
          style: TextStyle(color: Colors.white, backgroundColor: Colors.purpleAccent),
        ),
      );
      spans.add(
        TextSpan(
          text: text.substring(currentWordEnd),
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      spans.add(TextSpan(text: text, style: TextStyle(color: Colors.black)));
    }
    return spans;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVoices();
    fetchStories();
    handler();
    setState(() {
      if(widget.stories.isNotEmpty) stories = widget.stories;
    });

  }
  @override
  Widget build(BuildContext context) {
    return  stories.isEmpty?
    Center(child: Image.asset("assets/empty.png",height: 150,))
        :
    Scaffold(
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
          
            Column(
              children: [
                Text("Chapter ${selectedStoryIndex + 1}",
                  style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                Text(currentStory().title,
                  style: GoogleFonts.merriweather(
                      fontSize: 35,
                      fontWeight: FontWeight.w800
                  ),),
                Text.rich(
                  TextSpan(
                  children: _buildTextSpans(currentStory().content)
                  )
                ,
                  style: GoogleFonts.merriweather(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),),
          
          
          
              ],
            )
          ),
       
        ],
      ),
      bottomNavigationBar:  SizedBox(
        height: 100,
        child: Column(
          children: [
            LinearProgressIndicator(

              value:currentStory().content.isEmpty?0: end /  currentStory().content.length,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {showSettings(context);},
                      icon: Icon(Icons.settings, size: 20)),
                  IconButton(
                      onPressed: () {

                        if(selectedStoryIndex>0) {
                          setState(() {
                            selectedStoryIndex -= 1;
                          });
                          _pause();

                        }
                      },
                      icon: Icon(Icons.skip_previous,
                          color: selectedStoryIndex>0?Colors.black:Colors.grey,

                          size: 50)),
                  IconButton(

                      onPressed: () {
                        ttsState == TTsState.Playing?
                        _pause():
                        _speak(
                            text:currentStory().content
                        );
                      },
                      icon: Icon(
                        ttsState == TTsState.Playing? Icons.pause:Icons.play_arrow_rounded,
                        size: 80,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if(selectedStoryIndex<stories.length-1) {
                            selectedStoryIndex += 1;
                            _pause();

                          }
                        }

                        );
                      },
                      icon: Icon(
                        Icons.skip_next,
                        color: selectedStoryIndex>=stories.length-1?Colors.grey:null,
                        size: 50,
                      )),
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