import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

import 'details.dart';

class NewsTile extends StatefulWidget {
  //   title: snapshot.data[index].title,
  // author: snapshot.data[index].authors,
  // content: snapshot.data[index].content,
  // date: snapshot.data[index].date,
  // image: StringUtils.addCharAtPosition(snapshot.data[index].imageUrl, 's', 4),
  // website: snapshot.data[index].website,
  // tags: snapshot.data[index].tags[0],
  final List title;
  final List authors;
  final List content;
  final List date;
  final List image;
  final List website;
  int index;
  int sort;
  // final List questionPos;

  NewsTile({Key key, this.title, this.authors, this.content, this.date, this.image, this.website, this.index, this.sort}) : super(key: key);
  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  String title;
  String authors;
  String content;
  String date;
  String image;
  String website;
  int index;
  int sort;

  @override
  void initState() {
    index = widget.index;
    title = widget.title.elementAt(index);
    authors = widget.authors.elementAt(index);
    content = widget.content.elementAt(index);
    date = widget.date.elementAt(index);
    image = widget.image.elementAt(index);
    sort = widget.sort;
  }

  @override
  Widget build(BuildContext context) {
    print(sort);
    return ListTile(
      leading: Image.network(
        StringUtils.addCharAtPosition(image, 's', 4), // I need to add the 's' char because of this -> https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android
      ),
      title: Text(title),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(authors)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Text(date),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail(
                title: widget.title.elementAt(index),
                author: widget.authors.elementAt(index),
                content: widget.content.elementAt(index),
                date: widget.date.elementAt(index),
                image: StringUtils.addCharAtPosition(widget.image.elementAt(index), 's', 4),
                website: widget.website.elementAt(index),
                // tags: widget.image.elementAt(index),
              ),
            ));
      },
    );
  }
}
