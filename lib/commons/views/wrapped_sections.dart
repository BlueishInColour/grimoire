import 'package:flutter/material.dart';

class WrappedSectons extends StatefulWidget {
  const WrappedSectons({super.key,
  required this.currentSection,
    required this.currentCategory,

  required this.listOfSections,
  required this.onSectionClicked, required this.onCategoryClicked});
  final List<String> listOfSections;
  final Function(String currentSection,String currentCategory) onSectionClicked;
  final Function(String currentCategory,String currentSection ) onCategoryClicked;
  final String currentSection;
  final String currentCategory;

  @override
  State<WrappedSectons> createState() => _WrappedSectonsState();
}

class _WrappedSectonsState extends State<WrappedSectons> {
  Widget wrap(String title,bool isCurrentSection,{Color selectedColor =  Colors.blue,Color unSelectedColor =const  Color.fromRGBO(12, 21, 12, 12),required Function(String) onPressed}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),

      child: FilledButton.tonal(

          style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(22,22)),
              maximumSize: WidgetStatePropertyAll(Size(80,40)),

              textStyle: WidgetStatePropertyAll(
                TextStyle(
                  color:isCurrentSection?Colors.white70: Colors.black38,
                ),

              ),

              backgroundColor: WidgetStatePropertyAll(isCurrentSection?selectedColor:null)
              ,   padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 6))
          ),
          onPressed:()=>onPressed(title), child: Text(title,style: TextStyle(
          color:isCurrentSection?Colors.white70: Colors.black54,
          fontSize:8,
          overflow: TextOverflow.ellipsis


      ),)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          runSpacing: 0,

          spacing: 0,
          children:[
            "All","Hot","Latest","Highest Rated"
          ].map((v){return wrap(v,v == widget.currentCategory,selectedColor: Colors.black54,
          onPressed: (currentCategory)=>widget.onCategoryClicked(currentCategory,widget.currentSection)
          );}).toList() ,

        ),
        Wrap(
        runSpacing: 0,

        spacing: 0,

        children:widget.listOfSections.map((v){return wrap(v,v == widget.currentSection,onPressed: (currentSection)=> widget.onSectionClicked(currentSection,widget.currentCategory));}).toList() ,
      ),
        Divider(indent: 10,endIndent: 100,)
      ],);
  }
}
