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
    this.tags,
    @required this.image,
  });

  final String title;
  final String website;
  final String author;
  final String date;
  final String content;
  final String tags;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('test'),
    );
  }
}
