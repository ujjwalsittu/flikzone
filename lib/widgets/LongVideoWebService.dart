import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/LongVideos.dart';
import 'package:flickzone/models/videCategoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LongVideoWebService extends ChangeNotifier {
  Future<List<LongVideo>> loadLV(int userid) async {
    var url = Uri.http(kAppUrlHalf, 'video/lv/$userid');
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

  Future<List<LongVideoByID>> loadLVById(int id, int userid) async {
    var url = Uri.http(kAppUrlHalf, 'video/long/$id/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideoByID.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<LongVideoByUID>> loadLVByUId(int userid) async {
    var url = Uri.http(kAppUrlHalf, 'video/lv/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideoByUID.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<LongVideo>> loadAllLV() async {
    var url = Uri.http(kAppUrlHalf, 'video/longVid');
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

  Future<List<LongVideoByCatModel>> allLvById(int id) async {
    var url = Uri.http("3.109.150.228:4040", 'video/cat/$id');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => LongVideoByCatModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<VideoCategoryModel>> loadVideCat() async {
    var url = Uri.http("3.109.150.228:4040", 'video/allcategory');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => VideoCategoryModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
