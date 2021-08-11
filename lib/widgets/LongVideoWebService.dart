import 'dart:convert';

import 'package:flickzone/models/LongVideos.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LongVideoWebService extends ChangeNotifier {
  Future<List<LongVideo>> loadLV(int userid) async {
    var url = Uri.http("15.207.105.12:4040", 'video/lv/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideo.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<LongVideo>> loadLVById(int id) async {
    var url = Uri.http("15.207.105.12:4040", 'video/$id');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideo.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<LongVideo>> loadAllLV() async {
    var url = Uri.http("15.207.105.12:4040", 'video/longVid');
    print(url);
    final response = await http.post(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideo.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
