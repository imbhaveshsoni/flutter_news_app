import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/article_view.dart';

import 'categoty_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchText = "";
  TextEditingController controller = new TextEditingController();
  // ignore: deprecated_member_use
  List<CategoryModel> categories = new List<CategoryModel>();
  // ignore: deprecated_member_use
  List<ArticleModel>  articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews() async{
    News newscclass  =  News();
    await newscclass.getNews(searchText);
    articles = newscclass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News"),
            Text("Zone",style: TextStyle(color: Colors.blue),)
          ],
        ),
      ),
      body:_loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:16),
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName:categories[index].categoryName ,
                      );
                    }
                  ) ,
              ),
              ListTile(
                
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                    hintText: 'Search', border: InputBorder.none
                  ),
                  
                ),
                trailing: new IconButton(icon: new Icon(Icons.search),color: Colors.blue, onPressed: () {
                  searchText = controller.text;
                  getNews();
                  setState(() {});
                },),
                leading: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                  controller.clear();
                  searchText = "";
                  getNews();
                  setState(() {});
                  // onSearchTextChanged('');
                },),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title:articles[index].title ,
                      desc:articles[index].description ,
                      url:articles[index].url,
                    );
                  }),
              )
              
            ],),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl ,categoryName;
  CategoryTile({@required this.imageUrl , @required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> CategoryNews(
            category:categoryName.toLowerCase(), ) 
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right:10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:CachedNetworkImage(
                imageUrl: imageUrl,width:120,height:60,fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width:120,height:60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child:Text(categoryName,style: TextStyle(
                color:Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500 ),
                ) ,
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl ,@required  this.title ,@required  this.desc ,@required  this.url });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ArticleView(
              blogurl:url, ) )
            );
        },
          child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)
            ),
            SizedBox(height:8,),
            Text(title,style: TextStyle(
              fontSize:17 ,
              fontWeight: FontWeight.w500,),
              ),
            SizedBox(height:8,),
            Text(desc,style: TextStyle(
              color:Colors.grey ),
              ),
              
          ],
        ),
      ),
    );
  }
}