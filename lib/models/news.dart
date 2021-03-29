import 'tags.dart';

class News {
  String title;
  String website;
  String authors;
  String date;
  String content;
  List<Tags> tags;
  String imageUrl;
  bool isRead;

  News({this.title, this.website, this.authors, this.date, this.content, this.tags, this.imageUrl, this.isRead});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    website = json['website'];
    authors = json['authors'];
    date = json['date'];
    content = json['content'];
    if (json['tags'] != null) {
      // ignore: deprecated_member_use
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['website'] = this.website;
    data['authors'] = this.authors;
    data['date'] = this.date;
    data['content'] = this.content;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}
