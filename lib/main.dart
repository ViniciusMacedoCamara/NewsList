import 'dart:convert';

import 'package:baking_news_list/services/webservice.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:baking_news_list/models/news.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'view/detail.dart';

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
  News _news;

  @override
  void initState() {
    super.initState();
    futureNews = new WebService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<News>>(
            future: futureNews,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                // print(snapshot.data[0].tags[0].label);
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        StringUtils.addCharAtPosition(
                            snapshot.data[index].imageUrl, 's', 4), // I need to add the 's' char because of this -> https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android
                      ),
                      title: Text(snapshot.data[index].title),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(snapshot.data[index].authors)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text(snapshot.data[index].date),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                title: snapshot.data[index].title,
                                author: snapshot.data[index].authors,
                                content: snapshot.data[index].content,
                                date: snapshot.data[index].date,
                                image: StringUtils.addCharAtPosition(snapshot.data[index].imageUrl, 's', 4),
                                website: snapshot.data[index].website,
                                tags: snapshot.data[index].tags[0],
                              ),
                            ));
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
