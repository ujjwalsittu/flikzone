import 'package:video_player/video_player.dart';

class PostModel {
  String categoryType;
  String createdOn;
  String fullName;
  int hasImage;
  int id;
  int isLike;
  String location;
  int noOfComment;
  int noOfDislikes;
  int noOfFlicks;
  int noOfLikes;
  String postContent;
  String postImage;
  String profilepic;
  String postVideo;
  int status;
  int totalComment;
  int totalLike;
  String updatedON;
  int userId;

  PostModel(
      {required this.categoryType,
      required this.createdOn,
      required this.fullName,
      required this.hasImage,
      required this.id,
      required this.isLike,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlicks,
      required this.noOfLikes,
      required this.postContent,
      required this.postImage,
      required this.profilepic,
      required this.postVideo,
      required this.status,
      required this.totalComment,
      required this.totalLike,
      required this.updatedON,
      required this.userId});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      categoryType: json['categoryType'],
      createdOn: json['createdOn'],
      fullName: json['fullName'],
      hasImage: json['hasImage'],
      id: json['id'],
      isLike: json['isLike'],
      location: json['location'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlicks: json['noOfFlicks'],
      noOfLikes: json['noOfLikes'],
      postContent: json['postContent'],
      postImage: json['postImage'],
      profilepic: json['profilepic'],
      postVideo: json['postVideo'],
      status: json['status'],
      totalComment: json['totalComment'],
      totalLike: json['totalLike'],
      updatedON: json['updatedON'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryType'] = this.categoryType;
    data['createdOn'] = this.createdOn;
    data['fullName'] = this.fullName;
    data['hasImage'] = this.hasImage;
    data['id'] = this.id;
    data['isLike'] = this.isLike;
    data['location'] = this.location;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlicks'] = this.noOfFlicks;
    data['noOfLikes'] = this.noOfLikes;
    data['postContent'] = this.postContent;
    data['postImage'] = this.postImage;
    data['profilepic'] = this.profilepic;
    data['postVideo'] = this.postVideo;
    data['status'] = this.status;
    data['totalComment'] = this.totalComment;
    data['totalLike'] = this.totalLike;
    data['updatedON'] = this.updatedON;
    data['userId'] = this.userId;
    return data;
  }
}

class PostOfUser {
  String categoryType;
  String createdOn;
  int hasImage;
  int id;
  String location;
  int noOfComment;
  int noOfDislikes;
  int noOfFlicks;
  String postVideo;
  int noOfLikes;
  String postContent;
  String postImage;
  int status;
  String updatedON;
  int userId;

  PostOfUser(
      {required this.categoryType,
      required this.createdOn,
      required this.hasImage,
      required this.id,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlicks,
      required this.postVideo,
      required this.noOfLikes,
      required this.postContent,
      required this.postImage,
      required this.status,
      required this.updatedON,
      required this.userId});

  factory PostOfUser.fromJson(Map<String, dynamic> json) {
    return PostOfUser(
      categoryType: json['categoryType'],
      createdOn: json['createdOn'],
      hasImage: json['hasImage'],
      id: json['id'],
      postVideo: json['postVideo'],
      location: json['location'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlicks: json['noOfFlicks'],
      noOfLikes: json['noOfLikes'],
      postContent: json['postContent'],
      postImage: json['postImage'],
      status: json['status'],
      updatedON: json['updatedON'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryType'] = this.categoryType;
    data['createdOn'] = this.createdOn;
    data['hasImage'] = this.hasImage;
    data['id'] = this.id;
    data['location'] = this.location;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlicks'] = this.noOfFlicks;
    data['noOfLikes'] = this.noOfLikes;
    data['postContent'] = this.postContent;
    data['postImage'] = this.postImage;
    data['status'] = this.status;
    data['updatedON'] = this.updatedON;
    data['userId'] = this.userId;
    return data;
  }
}
