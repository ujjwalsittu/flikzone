import 'package:flutter/cupertino.dart';

class SinglePostModels {
  String categoryType;
  String createdOn;
  String fullName;
  int hasImage;
  int id;
  String location;
  int noOfComment;
  int noOfDislikes;
  int noOfFlicks;
  int noOfLikes;
  String postContent;
  String postImage;
  String profilepic;
  int status;
  String updatedON;
  int userId;
  String username;

  SinglePostModels(
      {required this.categoryType,
      required this.createdOn,
      required this.fullName,
      required this.hasImage,
      required this.id,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlicks,
      required this.noOfLikes,
      required this.postContent,
      required this.postImage,
      required this.profilepic,
      required this.status,
      required this.updatedON,
      required this.userId,
      required this.username});

  factory SinglePostModels.fromJson(Map<String, dynamic> json) {
    return SinglePostModels(
      categoryType: json['categoryType'],
      createdOn: json['createdOn'],
      fullName: json['fullName'],
      hasImage: json['hasImage'],
      id: json['id'],
      location: json['location'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlicks: json['noOfFlicks'],
      noOfLikes: json['noOfLikes'],
      postContent: json['postContent'],
      postImage: json['postImage'],
      profilepic: json['profilepic'],
      status: json['status'],
      updatedON: json['updatedON'],
      userId: json['userId'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryType'] = this.categoryType;
    data['createdOn'] = this.createdOn;
    data['fullName'] = this.fullName;
    data['hasImage'] = this.hasImage;
    data['id'] = this.id;
    data['location'] = this.location;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlicks'] = this.noOfFlicks;
    data['noOfLikes'] = this.noOfLikes;
    data['postContent'] = this.postContent;
    data['postImage'] = this.postImage;
    data['profilepic'] = this.profilepic;
    data['status'] = this.status;
    data['updatedON'] = this.updatedON;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
