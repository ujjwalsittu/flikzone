import 'dart:convert';

import 'package:flickzone/constants.dart';
import 'package:flickzone/models/notificationsModel.dart';
import 'package:http/http.dart' as http;

class LoadNotifications {
  Future<List<NotificationModel>> loadPosts(int userid) async {
    var url = Uri.http(kAppUrlHalf, 'notification/user/$userid');
    print(url);
    final response = await http.get(url);
    print(url);
    print(await http.get(url));
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      json = json["data"];
      final Iterable list = json;
      print(list);
      return list.map((item) => NotificationModel.fromJson(item)).toList();
    } else {
      throw Exception("Error Loading Posts");
    }
  }
}
