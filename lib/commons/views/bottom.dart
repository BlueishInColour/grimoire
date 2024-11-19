import 'package:animated_box_decoration/animated_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/main_controller.dart';
import 'package:provider/provider.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.child,this.backgroundColor= Colors.black});
  final Widget Function(double fontSize,double iconSize) child;
final Color backgroundColor ;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(
      builder:(context,c,child)=> Container(
        height: 50,
        width:400,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(30)
        ),
        child:c.isLoading?
        CircleAvatar(radius:10,
            backgroundColor: Colors.transparent,
            child: CircularProgressIndicator(color: Colors.black87,)): widget.child(12,20),
      ),
    );
  }
}
