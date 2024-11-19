import 'dart:ui';

import 'package:grimoire/main_controller.dart';

class StoryViewerUiController extends MainController{
  TextSize _textSize  = TextSize.VerySmall;
  TextSize get textSize => _textSize;
  set textSize(v){_textSize = v;notifyListeners();}


  Brightness _brightness = Brightness.Brown;
  Brightness get brightness => _brightness;
  set brightness(v){_brightness = v;notifyListeners();}



  double _speechRate = 0.3;
  double _pitch = 0.5;
  double _volume = 0.7;

  double get speechRate  => _speechRate;
  double get pitch  => _pitch;
  double get volume  => _volume;

  set speechRate(v){_speechRate=v;notifyListeners();}
  set pitch(v){_pitch=v;notifyListeners();}
  set volume(v){_volume=v;notifyListeners();}



}
enum Brightness{
  Light,
  Brown,
  Dark
}

enum TextSize{
  VerySmall,
  Small,
  Medium,
  Large,
  ExtraLarge
}
