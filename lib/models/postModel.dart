import 'package:video_player/video_player.dart';

class PostModel {
  String? username;
  int? id;
  int? userid;
  String? profilepic;
  int? noOfLikes;
  int? isLiked;
  String? postContent;
  String? postImage;
  int? hasImage;
  int? noOfComment;
  String? createdOn;

  PostModel(
      this.username,
      this.id,
      this.userid,
      this.profilepic,
      this.noOfLikes,
      this.isLiked,
      this.postContent,
      this.postImage,
      this.hasImage,
      this.noOfComment,
      this.createdOn);

  PostModel.fromJson(Map<String, dynamic> json)
      : username = json['fullName'],
        id = json['id'],
        userid = json['userid'],
        profilepic = json['profilepic'],
        noOfLikes = json['totalLike'],
        isLiked = json['isLike'],
        postContent = json['postContent'],
        postImage = json['postImage'],
        hasImage = json['hasImage'],
        noOfComment = json['totalComment'],
        createdOn = json['createdOn'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'userid': userid,
        'profilepic': profilepic,
        'totalLike': noOfLikes,
        'postContent': postContent,
        'postImage': postImage,
        'hasImage': hasImage,
        'totalComment': noOfComment,
        'createdOn': createdOn,
      };
}
