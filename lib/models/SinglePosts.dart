class SinglePost {
  String categoryType;
  String createdOn;
  int hasImage;
  int id;
  String location;
  int noOfComment;
  int noOfDislikes;
  int noOfFlicks;
  int noOfLikes;
  String postContent;
  String postImage;
  int status;
  String updatedON;
  int userId;

  SinglePost(
      {required this.categoryType,
      required this.createdOn,
      required this.hasImage,
      required this.id,
      required this.location,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlicks,
      required this.noOfLikes,
      required this.postContent,
      required this.postImage,
      required this.status,
      required this.updatedON,
      required this.userId});

  factory SinglePost.fromJson(Map<String, dynamic> json) {
    return SinglePost(
      categoryType: json['categoryType'],
      createdOn: json['createdOn'],
      hasImage: json['hasImage'],
      id: json['id'],
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
