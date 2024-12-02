import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grimoire/commons/views/paginated_view.dart';
import 'package:grimoire/news/news_model.dart';
import 'package:grimoire/news/news_repository.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(

          onSubmitted: (v)async{
            await NewsRepository().addNews(NewsModel(
                title: textController.text
            )).whenComplete((){
              textController.clear();
            });
          },
          controller: textController,
          decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: "create news",

              suffixIcon: IconButton(onPressed: ()async{

                await NewsRepository().addNews(NewsModel(
                  title: textController.text
                ))
                .whenComplete((){
                  textController.clear();
                });
              }, icon: Icon(Icons.upload))

          ),
        ),
      ),
      body: paginatedView(query: NewsRepository().ref, child: (datas,index){
        NewsModel news = NewsModel.fromJson(datas[index].data() as Map<String,dynamic>);
        return ListTile(
          title: Text(news.title),
        );
      }),
    );
  }
}
