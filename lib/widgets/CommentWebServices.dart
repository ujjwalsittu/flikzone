import 'dart:convert';

import 'package:flickzone/models/commentModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentWebServices {
  Future<List<CommentModel>> loadComment(int id) async {
    var url = Uri.http("15.207.105.12:4040", 'comment/post/$id');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => CommentModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
