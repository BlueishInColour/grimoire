import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_controller.dart';

Widget loadable({required Widget child}){
  return Consumer<MainController>(
      builder: (context,c,chil){
        if(c.isLoading){
          return GestureDetector(
            onTap: (){c.showSnackBar(context, "loading .......");},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox.square(dimension:15,child: CircularProgressIndicator(strokeWidth: 1,)),
            ),
          );

        }
        else return child;
      });
}