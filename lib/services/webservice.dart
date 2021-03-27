import 'dart:convert';
import 'package:baking_news_list/models/news.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<News>> fetchNews() async {
    final url = 'blog.cheesecakelabs.com';
    final endpoint = '/challenge/';
    final uri = Uri.https(url, endpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable decoded = jsonDecode(response.body);
      List<News> result = decoded.map((data) => News.fromJson(data)).toList();
      print(result.elementAt(0).toJson());
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
