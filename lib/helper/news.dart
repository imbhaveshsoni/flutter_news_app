import 'dart:convert';

import 'package:news_app/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news  = [];

  Future<void> getNews(String text) async{
    String newsurl = "";
    if(text == "" ){
      newsurl = "https://newsapi.org/v2/top-headlines?country=in&apiKey=7b33893615c04de195ce30fd71867650";
    }else{
      newsurl = "https://newsapi.org/v2/top-headlines?q=$text&sortBy=popularity&apiKey=7b33893615c04de195ce30fd71867650";
    }
    String url = newsurl;
     var response = await http.get(Uri.parse(url));
     var jsonData = jsonDecode(response.body);
     if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(articleModel);
        }

      });
    }
  }
}

class CategoryNewsclass{
  List<ArticleModel> news  = [];

  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=1abf06ee56d648efa63096d9d20bde41";
     var response = await http.get(Uri.parse(url));
     var jsonData = jsonDecode(response.body);
     if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(articleModel);
        }

      });
    }
  }
}

