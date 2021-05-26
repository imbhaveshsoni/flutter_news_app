import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogurl;
  ArticleView({@required this.blogurl, String imageUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(
        title: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children :<Widget>[
            Text("News"),
            Text("Zone",style: TextStyle(
              color: Colors.blue)
              ,)
          ]
        ),
        actions: <Widget>[
          Opacity(opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:16),
              child:Icon(Icons.save),
            )
          )
        ],
      ),
      body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl: widget.blogurl,
        onWebViewCreated: ((WebViewController webViewController){
          _controller.complete(webViewController);
        }),
      ),
      )
    );

  }
}