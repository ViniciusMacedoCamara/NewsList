import 'package:baking_news_list/models/tags.dart';
import 'package:baking_news_list/services/webservice.dart';
import 'package:baking_news_list/view/about.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baking_news_list/models/news.dart';
import 'package:google_fonts/google_fonts.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

enum MenuOption { Date, Title, Author, Original, About }

class _HomePageState extends State<HomePage> {
  Future futureNews;
  Tags tags;
  News _news;
  List<News> newsDataView = [];
  List<String> enumValues = [];
  bool isPassed = false;
  TextStyle touched = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xDE000000));
  TextStyle notTouched = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xDE000000));

  final String whichSort = 'Sort by ';

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
        // Popup menu for the user sort by Date | Title | Author and reset the list with the Original. There is also a About page
        actions: <Widget>[
          PopupMenuButton<MenuOption>(
              onSelected: (MenuOption result) {
                if (result.index == 0) {
                  setState(() {
                    Comparator<News> dateSort = (a, b) => a.date.compareTo(b.date);
                    newsDataView.sort(dateSort);
                  });
                } else if (result.index == 1) {
                  setState(() {
                    Comparator<News> titleSort = (a, b) => a.title.compareTo(b.title);
                    newsDataView.sort(titleSort);
                  });
                } else if (result.index == 2) {
                  setState(() {
                    Comparator<News> authorSort = (a, b) => a.authors.compareTo(b.authors);
                    newsDataView.sort(authorSort);
                  });
                } else if (result.index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(),
                    ),
                  );
                } else {
                  isPassed = false;
                  setState(() {
                    newsDataView;
                  });
                }
                // Shows a SnackBar to confirm what kinda of sort the user selected
                if (result.index == 3) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sort and read/unread restarted')));
                } else if (result.index == 0 || result.index == 1 || result.index == 2) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sorted by ' + enumValues.elementAt(result.index))));
                }
              },
              icon: Icon(Icons.sort),
              itemBuilder: (BuildContext context) {
                // Substring the menu option enum once and used it in the view
                for (MenuOption menuOption in MenuOption.values) {
                  enumValues.add(menuOption.toString().substring(menuOption.toString().indexOf('.') + 1));
                }
                // View for popup menu
                return <PopupMenuEntry<MenuOption>>[
                  PopupMenuItem(
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
                  PopupMenuItem(
                    child: Text(enumValues.elementAt(4)),
                    value: MenuOption.About,
                  ),
                ];
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          // Here is where the news list is created and rendered
          child: FutureBuilder<List<News>>(
            future: futureNews,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                if (isPassed == false) {
                  newsDataView = [];

                  // Add News into a list to be able to sort it
                  for (var i = 0; i < snapshot.data.length; i++) {
                    _news = new News(
                      title: snapshot.data[i].title,
                      authors: snapshot.data[i].authors,
                      content: snapshot.data[i].content,
                      date: snapshot.data[i].date,
                      imageUrl: snapshot.data[i].imageUrl,
                      website: snapshot.data[i].website,
                      tags: snapshot.data[i].tags,
                      isRead: false,
                    );

                    newsDataView.add(_news);
                  }
                  isPassed = true;
                }

                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 16, 0), // Can uncomment this to make image touch the left side of the screen
                      leading: CachedNetworkImage(
                        // placeholder: (context, url) => CircularProgressIndicator(), // Can uncomment this to enable progress indicator
                        imageUrl: StringUtils.addCharAtPosition(
                            newsDataView.elementAt(index).imageUrl, 's', 4), // I added the 's' char because of this -> https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        newsDataView.elementAt(index).title,
                        style: newsDataView.elementAt(index).isRead ? touched : notTouched,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(newsDataView.elementAt(index).authors)),
                            Text(newsDataView.elementAt(index).date),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Change the state to check what tile was selected to change the font style
                        setState(() {
                          newsDataView.elementAt(index).isRead = true;
                        });
                        // Push the selected tile into details page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                              title: newsDataView.elementAt(index).title,
                              author: newsDataView.elementAt(index).authors,
                              content: newsDataView.elementAt(index).content,
                              date: newsDataView.elementAt(index).date,
                              image: StringUtils.addCharAtPosition(newsDataView.elementAt(index).imageUrl, 's', 4),
                              website: newsDataView.elementAt(index).website,
                              tags: newsDataView.elementAt(index).tags.elementAt(0),
                              touched: newsDataView.elementAt(index).isRead,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        // Mark as unread and shows a SnackBar
                        setState(() {
                          newsDataView.elementAt(index).isRead = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item ' + (index + 1).toString() + ' is now marked as Unread')));
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      indent: 110,
                      thickness: 1.0,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                // In case user don't have internet when the app starts, this containers shows up
                // There is a button for the user to click when ensuring that the internet is back
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset('assets/img/dino.png'),
                        Text('Oops'),
                        Text('Looks like you don\'t'),
                        Text('have internet connection.'),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                futureNews = new WebService().fetchNews();
                              });
                            },
                            child: Text('Retry Connection'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
                          child: Text('Made with ??? by Vinicius Macedo Camara'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
