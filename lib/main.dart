import 'dart:convert';

import 'package:baking_news_list/models/tags.dart';
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
  Tags tags;
  int sort = 0;
  List<int> test;
  bool fdac = false;
  News _news;
  List<News> novas = [];
  List<String> enumValues = [];
  final String whichSort = 'Sort by ';
  bool isPassed = false;

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
          // IconButton(
          //   icon: Icon(Icons.sort),
          //   onPressed: () {
          //     setState(() {
          //       Comparator<News> datas = (a, b) => a.date.compareTo(b.date);
          //       novas.sort(datas);
          //     });
          //
          //     print(novas.elementAt(0).title);
          //   },
          // ),
          // Sort by data
          // Comparator<News> datas = (a, b) => a.date.compareTo(b.date);
          // novas.sort(datas);

          // Sort by title
          // Comparator<News> titulos = (a, b) => a.title.compareTo(b.title);
          // novas.sort(titulos);

          // Sort by author
          // Comparator<News> autores = (a, b) => a.authors.compareTo(b.authors);
          // novas.sort(autores);
          // PopupOptionMenu(),
          PopupMenuButton<MenuOption>(
              onSelected: (MenuOption result) {
                print(result);
                if (result.index == 0) {
                  setState(() {
                    // novas = [_news];
                    Comparator<News> datas = (a, b) => a.date.compareTo(b.date);
                    novas.sort(datas);
                  });
                } else if (result.index == 1) {
                  setState(() {
                    Comparator<News> titulos = (a, b) => a.title.compareTo(b.title);
                    novas.sort(titulos);
                  });
                } else if (result.index == 2) {
                  setState(() {
                    Comparator<News> autores = (a, b) => a.authors.compareTo(b.authors);
                    novas.sort(autores);
                  });
                } else {
                  isPassed = false;
                  setState(() {
                    novas;
                  });
                }
                print(result);
                print(novas.toList().toString());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorted by ' + enumValues.elementAt(result.index))));
              },
              icon: Icon(Icons.sort),
              itemBuilder: (BuildContext context) {
                for (MenuOption menuOption in MenuOption.values) {
                  enumValues.add(menuOption.toString().substring(menuOption.toString().indexOf('.') + 1));
                }
                return <PopupMenuEntry<MenuOption>>[
                  PopupMenuItem(
                    // child: Text('save'),
                    child: Text(whichSort + enumValues.elementAt(0)),
                    value: MenuOption.Date,
                  ),
                  PopupMenuItem(
                    child: Text(whichSort + enumValues.elementAt(1)),
                    value: MenuOption.Title,
                  ),
                  PopupMenuItem(
                    child: Text(whichSort + enumValues.elementAt(2)),
                    value: MenuOption.Author,
                  ),
                  PopupMenuItem(
                    child: Text(whichSort + enumValues.elementAt(3)),
                    value: MenuOption.Original,
                  ),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<News>>(
            future: futureNews,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                if (isPassed == false) {
                  novas = [];
                  for (var i = 0; i < snapshot.data.length; i++) {
                    // title.add(snapshot.data[i].title);
                    // authors.add(snapshot.data[i].authors);
                    // content.add(snapshot.data[i].content);
                    // date.add(snapshot.data[i].date);
                    // image.add(snapshot.data[i].imageUrl);
                    // website.add(snapshot.data[i].website);

                    _news = new News(
                      title: snapshot.data[i].title,
                      authors: snapshot.data[i].authors,
                      content: snapshot.data[i].content,
                      date: snapshot.data[i].date,
                      imageUrl: snapshot.data[i].imageUrl,
                      website: snapshot.data[i].website,
                      tags: snapshot.data[i].tags,
                    );

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
                  isPassed = true;
                }
                print(novas.elementAt(0).tags.elementAt(0).label);

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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              title: novas.elementAt(index).title,
                              author: novas.elementAt(index).authors,
                              content: novas.elementAt(index).content,
                              date: novas.elementAt(index).date,
                              image: StringUtils.addCharAtPosition(novas.elementAt(index).imageUrl, 's', 4),
                              website: novas.elementAt(index).website,
                              tags: novas.elementAt(index).tags.elementAt(0),
                            ),
                          ),
                        );
                      },
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

// testSort() {
//   setState(() {
//     Comparator<News> datas = (a, b) => a.date.compareTo(b.date);
//     novas.sort(datas);
//   });
// }

enum MenuOption { Date, Title, Author, Original }

// class PopupOptionMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<MenuOption>(
//         onSelected: (MenuOption result) {
//           if (result.index == 0) {
//             print(result);
//           }
//         },
//         icon: Icon(Icons.sort),
//         itemBuilder: (BuildContext context) {
//           return <PopupMenuEntry<MenuOption>>[
//             PopupMenuItem(
//               // child: Text('save'),
//               child: Icon(
//                 Icons.sort,
//                 color: Colors.black87,
//               ),
//               value: MenuOption.Save,
//             ),
//             PopupMenuItem(
//               child: Text('Discard'),
//               value: MenuOption.Discard,
//             ),
//             PopupMenuItem(
//               child: Text('Draft'),
//               value: MenuOption.Draft,
//             ),
//           ];
//         });
//   }
// }
