class CommentModel {
  String content;
  String createdOn;
  int dislikes;
  String fullName;
  int hasReply;
  int id;
  int likes;
  int postId;
  int replyId;
  int status;
  String updatedOn;
  int userId;
  String userPic;
  String username;
  int videoId;
  int maxReply;

  CommentModel(
      {required this.content,
      required this.createdOn,
      required this.dislikes,
      required this.fullName,
      required this.hasReply,
      required this.id,
      required this.likes,
      required this.postId,
      required this.replyId,
      required this.status,
      required this.updatedOn,
      required this.userId,
      required this.userPic,
      required this.username,
      required this.videoId,
      required this.maxReply});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      content: json['content'],
      createdOn: json['createdOn'],
      dislikes: json['dislikes'],
      fullName: json['fullName'],
      hasReply: json['hasReply'],
      id: json['id'],
      likes: json['likes'],
      postId: json['postId'],
      replyId: json['replyId'],
      status: json['status'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
      userPic: json['userPic'],
      username: json['username'],
      videoId: json['videoId'],
      maxReply: json['maxReply'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['createdOn'] = this.createdOn;
    data['dislikes'] = this.dislikes;
    data['fullName'] = this.fullName;
    data['hasReply'] = this.hasReply;
    data['id'] = this.id;
    data['likes'] = this.likes;
    data['postId'] = this.postId;
    data['replyId'] = this.replyId;
    data['status'] = this.status;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    data['userPic'] = this.userPic;
    data['username'] = this.username;
    data['videoId'] = this.videoId;
    data['maxReply'] = this.maxReply;
    return data;
  }
}
