import 'package:flutter/material.dart';

import '../CONSTANT.dart';

Widget loadWidget({Color color =Colors.white}){
  return Center(
    child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(color: color,

        strokeWidth: 1,),
    ),
  );
}