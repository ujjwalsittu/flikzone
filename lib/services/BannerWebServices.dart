import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/BannerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BannerWebService extends ChangeNotifier {
  Future<List> loadBanner() async {
    var url = Uri.http(kAppUrlHalf, 'banner');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Iterable list = json["data"];

      return list.map((item) => (item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
