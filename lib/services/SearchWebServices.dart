import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/SearchModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SearchWebService extends ChangeNotifier {
  Future<List<User>> loadSearch(String query) async {
    var url = Uri.http(kAppUrlHalf, 'search/2/${query}');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      json = json["data"];
      final Iterable list = json["user"];

      return list.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<Post>> loadPostSearch(String query) async {
    var url = Uri.http(kAppUrlHalf, 'search/3/${query}');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      json = json["data"];
      final Iterable list = json["post"];

      return list.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<Video>> loadVideoSearch(String query) async {
    var url = Uri.http(kAppUrlHalf, 'search/4/${query}');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      json = json["data"];
      final Iterable list = json["video"];

      return list.map((item) => Video.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
