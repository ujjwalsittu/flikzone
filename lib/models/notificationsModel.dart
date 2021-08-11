import 'package:flutter/cupertino.dart';

class NotificationModel {
  int userId;
  String content;
  int notificationType;
  String createdOn;

  NotificationModel(
      {required this.userId,
      required this.content,
      required this.notificationType,
      required this.createdOn});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        content = json['content'],
        notificationType = json['notificationType'],
        createdOn = json['createdOn'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'content': content,
        'notificationType': notificationType,
        'createdOn': createdOn,
      };
}
