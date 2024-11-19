import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.child});
  final Widget Function(double fontSize,double iconSize) child;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(35),

        ),
        child: widget.child(15,15),
      ),
    );
  }
}
