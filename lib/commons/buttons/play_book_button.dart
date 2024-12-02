import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';


class PlayBookButton extends StatefulWidget {
  const PlayBookButton({super.key,required this.filePath,required this.isFile});
  final String filePath;
  final bool isFile;

  @override
  State<PlayBookButton> createState() => _PlayBookButtonState();
}

class _PlayBookButtonState extends State<PlayBookButton> {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  int end = 0;
  String pdfText = "";


  getPdfText()async{
    if(widget.isFile){
    //
    //   setState(() {
    //     pdfText = docText;
    //   });
    //   return docText;
    //
    // }
    // else{
    //   PDFDoc doc = await PDFDoc.fromURL(widget.filePath);
    //   String docText = await doc.text;
    //   setState(() {
    //     pdfText = docText;
    //   });
    //   return docText;
    //
    // }
  }}

  playPdfText()async{
    String pdfText= await getPdfText();


    flutterTts.setLanguage("en-US");
    if (pdfText != null) {
      await flutterTts.awaitSpeakCompletion(true);
      setState(() {
        isSpeaking =true;
      });
  await  flutterTts.speak(pdfText);

  }}
  pausePdfText()async{
   await flutterTts.pause().whenComplete((){
     setState(() {
       isSpeaking  = false;
     });
   });
  }
  Widget _progressBar(int end,Widget child,String pdfText) => Stack(
    children: [
      CircularProgressIndicator(
        color: Colors.white70,

        value:pdfText.isEmpty?0: end /  pdfText.length,
      ),
      Positioned(
          top: 0,
  left: 0,
  right: 0,
  bottom: 0,
          child: Center(child: child,))
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterTts.setProgressHandler(
            (String text, int startOffset, int endOffset, String word) {
          setState(() {
            end = endOffset;
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: IconButton.filled(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
          onPressed: () async {
            if (isSpeaking) {
              await pausePdfText();
            } else {
              await playPdfText();
            }
          },
          icon: _progressBar(
              end,
              Icon(
                isSpeaking ? Icons.pause : Icons.play_arrow,
                color: Colors.white70,
              ),
              pdfText
          )),
    );
  }
}
