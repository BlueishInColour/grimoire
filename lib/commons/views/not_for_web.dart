import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Widget notForWeb({required Widget child}){
  if(kIsWeb){return SizedBox();}
  else{
    return child;
  }
}
Widget forWebOnly({required Widget child}){
  if(kIsWeb){return child;}
  else{
    return SizedBox();
  }
}