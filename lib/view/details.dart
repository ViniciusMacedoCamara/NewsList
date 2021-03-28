import 'package:baking_news_list/models/tags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  Detail({
    @required this.title,
    @required this.website,
    @required this.author,
    @required this.date,
    @required this.content,
    @required this.tags,
    @required this.image,
    @required this.touched,
  });

  final String title;
  final String website;
  final String author;
  final String date;
  final String content;
  final Tags tags;
  final String image;
  final bool touched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(image, fit: BoxFit.fitWidth),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Updated on ' + date),
                    ),
                    Text(tags.label + ' news'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content,
                  style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text('Source: ' + website),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: ElevatedButton(
                  child: Text('Mark as Unread'),
                  onPressed: () {
                    print(touched);
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
