import 'dart:convert';

import 'package:baking_news_list/services/webservice.dart';
import 'package:baking_news_list/view/newsTile.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:baking_news_list/models/news.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'view/details.dart';
import 'package:grouped_list/grouped_list.dart';

void main() {
  runApp(NewsList());
}

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(title: 'News'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future futureNews;
  List<String> title = [];
  List<String> authors = [];
  List<String> content = [];
  List<String> date = [];
  List<String> image = [];
  List<String> website = [];
  // List<String> tags = [];
  int sort = 0;
  List<int> test;
  bool fdac = false;
  News _news;
  List<News> novas = [];

  List news = [];

  @override
  void initState() {
    super.initState();
    futureNews = new WebService().fetchNews();
    // test = [4, 0, 3, 5, 1, 2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupOptionMenu(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<News>>(
            future: futureNews,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  title.add(snapshot.data[i].title);
                  authors.add(snapshot.data[i].authors);
                  content.add(snapshot.data[i].content);
                  date.add(snapshot.data[i].date);
                  image.add(snapshot.data[i].imageUrl);
                  website.add(snapshot.data[i].website);

                  _news = new News(
                      title: snapshot.data[i].title,
                      authors: snapshot.data[i].authors,
                      content: snapshot.data[i].content,
                      date: snapshot.data[i].date,
                      imageUrl: snapshot.data[i].imageUrl,
                      website: snapshot.data[i].website);

                  novas.add(_news);

                  // print(_news.title);
                  // var newsInfo = {
                  //   'title': snapshot.data[i].title,
                  //   'authors': snapshot.data[i].authors,
                  //   'content': snapshot.data[i].content,
                  //   'date': snapshot.data[i].date,
                  //   'image': snapshot.data[i].imageUrl,
                  //   'website': snapshot.data[i].website
                  // };
                  // news.add(newsInfo);
                }

                // print(date);
                // date.sort();
                // print(date);
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        StringUtils.addCharAtPosition(
                            novas.elementAt(index).imageUrl, 's', 4), // I added the 's' char because of this -> https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android
                      ),
                      title: Text(novas.elementAt(index).title),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(novas.elementAt(index).authors)),
                          Text(novas.elementAt(index).date),
                        ],
                      ),
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Detail(
                      //         title: snapshot.data[index].title,
                      //         author: snapshot.data[index].authors,
                      //         content: snapshot.data[index].content,
                      //         date: snapshot.data[index].date,
                      //         image: StringUtils.addCharAtPosition(snapshot.data[index].imageUrl, 's', 4),
                      //         website: snapshot.data[index].website,
                      //         tags: snapshot.data[0].tags[0],
                      //       ),
                      //     ),
                      //   );
                      // },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      indent: 20,
                      endIndent: 20,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('data has error');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

enum MenuOption { Save, Discard, Draft }

class PopupOptionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
        onSelected: (MenuOption result) {
          print(result);
        },
        icon: Icon(Icons.sort),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(
              // child: Text('save'),
              child: Icon(
                Icons.sort,
                color: Colors.black87,
              ),
              value: MenuOption.Save,
            ),
            PopupMenuItem(
              child: Text('Discard'),
              value: MenuOption.Discard,
            ),
            PopupMenuItem(
              child: Text('Draft'),
              value: MenuOption.Draft,
            ),
          ];
        });
  }
}
