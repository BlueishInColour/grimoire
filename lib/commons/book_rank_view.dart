import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BookRankView extends StatefulWidget {
  const BookRankView({super.key});

  @override
  State<BookRankView> createState() => _BookRankViewState();
}

class _BookRankViewState extends State<BookRankView> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: CarouselSlider(

        options: CarouselOptions(
            height: 400.0,

          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: (index,reason){},
          scrollDirection: Axis.horizontal,),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(

                  width: MediaQuery.of(context).size.width -100,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  foregroundDecoration: ShapeDecoration(
                    shape: RoundedRectangleBorder()
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),

      ),
    );
  }
}
