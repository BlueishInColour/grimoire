import 'package:flutter/material.dart';

import '../../constant/CONSTANT.dart';

Widget loadWidget({Color color =Colors.black}){
  return Center(
    child: SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(color: color),
    ),
  );
}