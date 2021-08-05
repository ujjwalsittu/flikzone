import 'package:flutter/cupertino.dart';

class NotificationModel {
  String name;
  String faceUrl;
  String message;

  String time;
  IconData? icon;

  NotificationModel(
      {required this.name,
      required this.faceUrl,
      required this.message,
      required this.time,
      this.icon});
}
