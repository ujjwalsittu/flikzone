import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/SearchModel.dart';
import 'package:flickzone/models/singlePostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SinglePostService extends ChangeNotifier {
  Future<List<SinglePostModels>> loadPostData(int query) async {
    var url = Uri.http(kAppUrlHalf, 'post/$query');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // json = json["data"];
      final Iterable list = json["data"];

      return list.map((item) => SinglePostModels.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
