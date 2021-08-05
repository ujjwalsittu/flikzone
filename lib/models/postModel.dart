class PostModel {
  String? username;
  int? userid;
  String? profilepic;
  int? noOfLikes;
  String? postContent;
  String? postImage;
  int? hasImage;
  int? noOfComment;
  String? createdOn;

  PostModel(
      this.username,
      this.userid,
      this.profilepic,
      this.noOfLikes,
      this.postContent,
      this.postImage,
      this.hasImage,
      this.noOfComment,
      this.createdOn);

  PostModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        userid = json['userid'],
        profilepic = json['profilepic'],
        noOfLikes = json['noOfLikes'],
        postContent = json['postContent'],
        postImage = json['postImage'],
        hasImage = json['hasImage'],
        noOfComment = json['noOfComment'],
        createdOn = json['createdOn'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'userid': userid,
        'profilepic': profilepic,
        'noOfLikes': noOfLikes,
        'postContent': postContent,
        'postImage': postImage,
        'hasImage': hasImage,
        'noOfComment': noOfComment,
        'createdOn': createdOn,
      };
}
