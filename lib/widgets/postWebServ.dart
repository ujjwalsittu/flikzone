/*
 * Copyright (c) 2021. All Rights Reserved, You are not allowed, distribute and modify this code under the terms of the of genric license issued by Musocial Private Limited. If any person / company wants to modify the code, he/she/they need to get developer license issued by Musocial Private Limited. If any person / company wants to distribute this code he/she/they need to get affliate / reseller license issued by Musocial Private Limited.
 * If any person / company is found to violate our copyright terms and licensing terms. we are completely liable to take legal actions under Copyright act, or any as per applicable by local law authorities.
 *
 * This code is documented and written by author : Ujjwal Kumar Sittu
 *
 */
import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/postModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PostWebServices extends ChangeNotifier {
  Future<List<PostModel>> loadPosts(int userid) async {
    var url = Uri.http(kAppUrlHalf, 'post/user/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }

  Future<List<PostOfUser>> loadUserPost(int userid) async {
    var url = Uri.http(kAppUrlHalf, '/post/posts/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => PostOfUser.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
