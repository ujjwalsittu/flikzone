class LongVideo {
  int canCommnet;
  String category;
  String createdOn;
  String descrition;
  String hasTags;
  int id;
  int isLong;
  String location;
  int musicId;
  String musicThumbNailUrl;
  int noOfComment;
  int noOfDislikes;
  int noOfFlick;
  int noOfLikes;
  int status;
  String thumbnailUrl;
  String updatedOn;
  int userId;
  String videoUrl;

  LongVideo(
      {required this.canCommnet,
      required this.category,
      required this.createdOn,
      required this.descrition,
      required this.hasTags,
      required this.id,
      required this.isLong,
      required this.location,
      required this.musicId,
      required this.musicThumbNailUrl,
      required this.noOfComment,
      required this.noOfDislikes,
      required this.noOfFlick,
      required this.noOfLikes,
      required this.status,
      required this.thumbnailUrl,
      required this.updatedOn,
      required this.userId,
      required this.videoUrl});

  factory LongVideo.fromJson(Map<String, dynamic> json) {
    return LongVideo(
      canCommnet: json['canCommnet'],
      category: json['category'],
      createdOn: json['createdOn'],
      descrition: json['descrition'],
      hasTags: json['hasTags'],
      id: json['id'],
      isLong: json['isLong'],
      location: json['location'],
      musicId: json['musicId'],
      musicThumbNailUrl: json['musicThumbNailUrl'],
      noOfComment: json['noOfComment'],
      noOfDislikes: json['noOfDislikes'],
      noOfFlick: json['noOfFlick'],
      noOfLikes: json['noOfLikes'],
      status: json['status'],
      thumbnailUrl: json['thumbnailUrl'],
      updatedOn: json['updatedOn'],
      userId: json['userId'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canCommnet'] = this.canCommnet;
    data['category'] = this.category;
    data['createdOn'] = this.createdOn;
    data['descrition'] = this.descrition;
    data['hasTags'] = this.hasTags;
    data['id'] = this.id;
    data['isLong'] = this.isLong;
    data['location'] = this.location;
    data['musicId'] = this.musicId;
    data['musicThumbNailUrl'] = this.musicThumbNailUrl;
    data['noOfComment'] = this.noOfComment;
    data['noOfDislikes'] = this.noOfDislikes;
    data['noOfFlick'] = this.noOfFlick;
    data['noOfLikes'] = this.noOfLikes;
    data['status'] = this.status;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['updatedOn'] = this.updatedOn;
    data['userId'] = this.userId;
    data['videoUrl'] = this.videoUrl;
    return data;
  }
}
