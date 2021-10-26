import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/ShortVideo.dart';
import 'package:flickzone/models/StoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StoryWebServices extends ChangeNotifier {
  Future<List<StoryModel>> loadStory() async {
    var url = Uri.http(kAppUrlHalf, 'story');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => StoryModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  // Future<List<ShortVideo>> loadAllLV() async {
  //   var url = Uri.http("15.207.105.12:4040", 'video/shortVid');
  //   print(url);
  //   final response = await http.post(url);
  //   print(url);
  //   print(await http.get(url));
  //   print(response.body);
  //   print(response.statusCode);
  //
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     final Iterable list = json["data"];
  //
  //     return list.map((item) => ShortVideo.fromJson(item)).toList();
  //   } else {
  //     throw Exception("Error Loading Posts");
  //   }
  // }
}
